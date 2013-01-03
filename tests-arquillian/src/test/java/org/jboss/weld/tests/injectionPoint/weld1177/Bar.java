package org.jboss.weld.tests.injectionPoint.weld1177;

import javax.enterprise.context.Dependent;
import javax.enterprise.context.RequestScoped;
import javax.enterprise.inject.spi.InjectionPoint;
import javax.inject.Inject;

/**
 *
 */
@Dependent
public class Bar {

    @Inject
    InjectionPoint injectionPoint;


}
