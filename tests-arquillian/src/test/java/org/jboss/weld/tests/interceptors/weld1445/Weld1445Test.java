package org.jboss.weld.tests.interceptors.weld1445;

import static org.junit.Assert.*;

import javax.enterprise.event.Event;
import javax.inject.Inject;

import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.junit.Arquillian;
import org.jboss.shrinkwrap.api.Archive;
import org.jboss.shrinkwrap.api.BeanArchive;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.jboss.weld.tests.category.Integration;
import org.junit.Assert;
import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.runner.RunWith;

/**
 *
 */
@RunWith(Arquillian.class)
@Category(Integration.class)
public class Weld1445Test {

    @Deployment
    public static Archive<?> getDeployment() {
        return ShrinkWrap.create(BeanArchive.class)
                .intercept(ContextInterceptor.class)
                .addPackage(Weld1445Test.class.getPackage());
    }

    @Inject
    private Event<Message> event;

    @Test
    public void testObserverMethodIsIntercepted() {
        ButtonPressedEventHandler.observed = false;
        ContextInterceptor.invoked = false;

        event.fire(new Message());
        assertTrue(ButtonPressedEventHandler.observed);
        assertTrue(ContextInterceptor.invoked);
    }

}
