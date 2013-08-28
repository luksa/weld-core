package org.jboss.weld.tests.resolution.weld1485;

import javax.enterprise.inject.Produces;
import javax.enterprise.inject.spi.InjectionPoint;

/**
 *
 */
public class Producer {

    @Produces
    public <T> Foo<T> produceFoo(InjectionPoint injectionPoint) {
        return new Foo<T>();
    }


}
