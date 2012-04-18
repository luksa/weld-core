package org.jboss.weld.tests.stereotypes.named;

import junit.framework.Assert;
import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.junit.Arquillian;
import org.jboss.shrinkwrap.api.Archive;
import org.jboss.shrinkwrap.api.BeanArchive;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.junit.Test;
import org.junit.runner.RunWith;

import javax.inject.Inject;
import javax.inject.Named;

/**
 *
 */
@RunWith(Arquillian.class)
public class InjectBeanNamedThroughStereotypeTest {

    @Deployment
    public static Archive<?> deploy() {
        return ShrinkWrap.create(BeanArchive.class)
            .addClasses(MyStereotype.class, MyBean.class);
    }

    @Inject
    @Named
    private MyBean myBean;

    @Test
    public void testInjection() {
        Assert.assertNotNull(myBean);
    }


}
