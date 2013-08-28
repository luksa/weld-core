package org.jboss.weld.tests.resolution.weld1485;

import javax.inject.Inject;

import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.junit.Arquillian;
import org.jboss.shrinkwrap.api.Archive;
import org.jboss.shrinkwrap.api.BeanArchive;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.jboss.weld.tests.util.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;

/**
 *
 */
@RunWith(Arquillian.class)
public class Weld1485Test {

    @Deployment
    public static Archive<?> deploy() {
        return ShrinkWrap.create(BeanArchive.class)
            .addPackage(Weld1485Test.class.getPackage());
    }

    @Inject
    private Client client;

    @Test
    public void testInjection() {
        Assert.assertNotNull(client.getWildcardFoo());
        Assert.assertNotNull(client.getWildcardListFoo());
    }


}
