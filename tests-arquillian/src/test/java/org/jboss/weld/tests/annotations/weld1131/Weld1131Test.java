package org.jboss.weld.tests.annotations.weld1131;

import junit.framework.Assert;
import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.junit.Arquillian;
import org.jboss.shrinkwrap.api.Archive;
import org.jboss.shrinkwrap.api.BeanArchive;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.junit.Test;
import org.junit.runner.RunWith;

import javax.inject.Inject;

/**
 *
 */
@RunWith(Arquillian.class)
public class Weld1131Test {

    @Deployment
    public static Archive<?> createTestArchive() {
        return ShrinkWrap.create(BeanArchive.class)
            .addPackage(Weld1131Test.class.getPackage());
    }

    @Inject
    private Foo foo;

    @Test
    public void testAnnotations() throws Exception {
        MyAnnotation myAnnotation = foo.getClass().getMethod("getBar").getAnnotation(MyAnnotation.class);
        Assert.assertNotNull(myAnnotation);
    }

}
