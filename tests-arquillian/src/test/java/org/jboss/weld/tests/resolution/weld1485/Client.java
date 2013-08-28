package org.jboss.weld.tests.resolution.weld1485;

import java.util.List;

import javax.inject.Inject;

/**
 *
 */
public class Client {

    @Inject
    private Foo<?> wildcardFoo;

    @Inject
    private Foo<List<?>> wildcardListFoo;

    public Foo<?> getWildcardFoo() {
        return wildcardFoo;
    }

    public Foo<List<?>> getWildcardListFoo() {
        return wildcardListFoo;
    }
}
