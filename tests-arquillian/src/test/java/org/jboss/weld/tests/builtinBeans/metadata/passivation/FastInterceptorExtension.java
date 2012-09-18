/*
 * JBoss, Home of Professional Open Source
 * Copyright 2012, Red Hat, Inc., and individual contributors
 * by the @authors tag. See the copyright.txt in the distribution for a
 * full listing of individual contributors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.jboss.weld.tests.builtinBeans.metadata.passivation;

import java.lang.annotation.Annotation;
import java.util.Collections;
import java.util.Set;

import javax.enterprise.event.Observes;
import javax.enterprise.inject.spi.AfterBeanDiscovery;
import javax.enterprise.inject.spi.AnnotatedType;
import javax.enterprise.inject.spi.Bean;
import javax.enterprise.inject.spi.BeanAttributes;
import javax.enterprise.inject.spi.BeanManager;
import javax.enterprise.inject.spi.Extension;
import javax.enterprise.inject.spi.InjectionPoint;
import javax.enterprise.inject.spi.InjectionTarget;
import javax.enterprise.inject.spi.InterceptionType;
import javax.enterprise.inject.spi.ProcessInjectionPoint;
import javax.interceptor.InvocationContext;

import org.jboss.weld.injection.ForwardingInjectionPoint;

/**
 * Register {@link FastInterceptor} as an interceptor using {@link AbstractPassivationCapableInterceptorImpl}.
 * 
 * @author Jozef Hartinger
 * 
 */
public class FastInterceptorExtension implements Extension {

    private AbstractPassivationCapableInterceptorImpl<FastInterceptor> interceptor;

    void registerInterceptor(@Observes AfterBeanDiscovery event, BeanManager manager) {
        AnnotatedType<FastInterceptor> annotatedType = manager.createAnnotatedType(FastInterceptor.class);
        BeanAttributes<FastInterceptor> attributes = manager.createBeanAttributes(annotatedType);
        Set<Annotation> interceptorBindings = Collections.<Annotation> singleton(Fast.Literal.INSTANCE);
        Set<InterceptionType> interceptionTypes = Collections.singleton(InterceptionType.AROUND_INVOKE);
        this.interceptor = new AbstractPassivationCapableInterceptorImpl<FastInterceptor>(FastInterceptor.class, attributes,
                interceptorBindings, interceptionTypes) {
            @Override
            public Object intercept(InterceptionType type, FastInterceptor instance, InvocationContext ctx) throws Exception {
                return instance; // instead of intercepting return the interceptor instance so that we can examine its state
            }
        };
        InjectionTarget<FastInterceptor> injectionTarget = manager.createInjectionTarget(annotatedType);
        this.interceptor.setInjectionTarget(injectionTarget);
        event.addBean(interceptor);
    }

    void wrapInjectionPoints(@Observes ProcessInjectionPoint<FastInterceptor, ?> event) {
        final InjectionPoint delegate = event.getInjectionPoint();
        if (delegate.getBean() == null) {
            event.setInjectionPoint(new ForwardingInjectionPoint() {

                @Override
                public Bean<?> getBean() {
                    return interceptor;
                }

                @Override
                protected InjectionPoint delegate() {
                    return delegate;
                }
            });
        }
    }
}
