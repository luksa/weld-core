package org.jboss.weld.tests.stereotypes.named;

import junit.framework.Assert;
import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.junit.Arquillian;
import org.jboss.shrinkwrap.api.Archive;
import org.jboss.shrinkwrap.api.BeanArchive;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.junit.Test;
import org.junit.runner.RunWith;

import javax.enterprise.inject.spi.Bean;
import javax.enterprise.inject.spi.BeanManager;
import java.util.Set;

/**
 *
 */
@RunWith(Arquillian.class)
public class LookupBeanNamedThroughStereotypeTest {

    @Deployment
    public static Archive<?> deploy() {
        return ShrinkWrap.create(BeanArchive.class)
            .addClasses(MyStereotype.class, MyBean.class);
    }

    @Test
    public void testLookupByName(BeanManager beanManager) {
        Set<Bean<?>> beans = beanManager.getBeans("myBean");
        Assert.assertEquals(1, beans.size());

        Bean<?> bean = beanManager.resolve(beans);
        Assert.assertNotNull(bean);

        Object reference = beanManager.getReference(bean, MyBean.class, beanManager.createCreationalContext(bean));
        Assert.assertNotNull(reference);
    }

}
