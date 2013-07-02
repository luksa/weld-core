package org.jboss.weld.tests.interceptors.weld1445;

import java.io.Serializable;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.enterprise.event.Observes;

/**
 *
 */
@Stateless
//@Local
@EventContextual //  just in case method annotation does not work
public class ButtonPressedEventHandler implements Serializable {

    public static boolean observed;

    @EventContextual
    public void observeStringEvent(@Observes Message event) {
        observed = true;
    }
}