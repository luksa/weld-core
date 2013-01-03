package org.jboss.weld.tests.injectionPoint.weld1177;

import javax.enterprise.inject.Instance;
import javax.enterprise.inject.spi.InjectionPoint;
import javax.inject.Inject;

import junit.framework.Assert;
import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.junit.Arquillian;
import org.jboss.shrinkwrap.api.Archive;
import org.jboss.shrinkwrap.api.BeanArchive;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.jboss.weld.test.util.Utils;
import org.junit.Test;
import org.junit.runner.RunWith;

import static junit.framework.Assert.*;

/**
 *
 */
@RunWith(Arquillian.class)
public class Weld1177Test {

    @Deployment
    public static Archive<?> deploy() {
        return ShrinkWrap.create(BeanArchive.class)
                .addPackage(Weld1177Test.class.getPackage())
                .addClass(Utils.class);
    }

    @Inject
    private Foo foo;

    @Inject
    private Foo foo2;

//    @Inject
//    private Bar bar;
//
//    @Inject
//    private Instance<Foo> fooInstance;
//
//    @Test
//    public void testInjectionPointInManagedBean() throws Exception {
//        assertNotNull(bar.injectionPoint);
//        assertEquals(Weld1177Test.class.getDeclaredField("bar"), bar.getInjectionPoint().getMember());
//        assertEquals(Bar.class, bar.getInjectionPoint().getType());
//    }

    @Test
    public void testInjectionPointInSLSB() throws Exception {
        foo.doSomething();
        foo2.doSomething();
        InjectionPoint fooInjectionPoint = foo.getInjectionPoint();
        InjectionPoint foo2InjectionPoint = foo2.getInjectionPoint();
        assertNotNull(fooInjectionPoint);
        assertNotNull(foo2InjectionPoint);
        assertEquals(Weld1177Test.class.getDeclaredField("foo"), fooInjectionPoint.getMember());
        assertEquals(Weld1177Test.class.getDeclaredField("foo2"), foo2InjectionPoint.getMember());
        assertEquals(Foo.class, fooInjectionPoint.getType());
        assertEquals(Foo.class, foo2InjectionPoint.getType());
    }
//
    @Test
    public void testInjectionPointInSLSB2() throws Exception {
        foo.doSomething();
        foo2.doSomething();
        assertEquals(Weld1177Test.class.getDeclaredField("foo"), foo.getInjectionPointMember());
        assertEquals(Weld1177Test.class.getDeclaredField("foo2"), foo2.getInjectionPointMember());
        assertEquals(Foo.class, foo.getInjectionPointType());
        assertEquals(Foo.class, foo2.getInjectionPointType());
    }

//    @Test
//    public void testInjectionPointInSLSB() throws Exception {
//        foo.doSomething();
//        assertNotNull(foo.getInjectionPoint());
//        assertEquals(Weld1177Test.class.getDeclaredField("foo"), foo.getInjectionPoint().getMember());
//        assertEquals(Foo.class, foo.getInjectionPoint().getType());
//    }
//
//    @Test
//    public void testInjectionPointInSLSBWithInstance() throws Exception {
//        Foo foo = fooInstance.get();
//        foo.doSomething();
//        assertNotNull(foo.getInjectionPoint());
//        assertEquals(Foo.class, foo.getInjectionPoint().getType());
//    }

}
