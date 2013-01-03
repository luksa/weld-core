package org.jboss.weld.tests.injectionPoint.weld1177;

import java.lang.reflect.Field;
import java.lang.reflect.Member;
import java.lang.reflect.Type;

import javax.ejb.Singleton;
import javax.ejb.Stateless;
import javax.enterprise.context.Dependent;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.inject.spi.InjectionPoint;
import javax.inject.Inject;

/**
 *
 */
@Stateless
@Dependent
public class Foo {

    @Inject
    private InjectionPoint injectionPoint;

//    @Inject
//    Baz baz;

//    @Inject
//    public void setInjectionPoint(InjectionPoint injectionPoint) {
//        this.injectionPoint = injectionPoint;
//    }

    public InjectionPoint getInjectionPoint() {
        return injectionPoint;
    }

    public void doSomething() {
        System.out.println("System.identityHashCode(this) = " + System.identityHashCode(this));
    }

    public Member getInjectionPointMember() {
        return injectionPoint.getMember();
    }

    public Type getInjectionPointType() {
        return injectionPoint.getType();
    }
}
