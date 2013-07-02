package org.jboss.weld.tests.interceptors.weld1445;

import javax.interceptor.AroundInvoke;
import javax.interceptor.Interceptor;
import javax.interceptor.InvocationContext;

/**
 *
 */
@EventContextual @Interceptor
public class ContextInterceptor {

    public static boolean invoked;

    @AroundInvoke
    public Object injectContext(InvocationContext context) throws Exception {
        invoked = true;
        return context.proceed();
    }

}