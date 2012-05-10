package org.jboss.weld.tests.annotations.weld1131;

import javax.enterprise.context.RequestScoped;
import java.io.Serializable;

/**
 *
 */
@RequestScoped
@MyAnnotation
public class Foo implements Serializable {

    public Foo() {
    }

    @MyAnnotation
    public String getBar() {
        return "bar";
    }
}
