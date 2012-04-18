package org.jboss.weld.tests.stereotypes.named;

import javax.enterprise.inject.Stereotype;
import javax.inject.Named;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 *
 */
@Named
@Stereotype
@Target({TYPE})
@Retention(RUNTIME)
public @interface MyStereotype {

}
