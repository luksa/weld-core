package org.jboss.weld.tests.contexts.conversation.timeout;

import java.io.Serializable;

import javax.enterprise.context.ConversationScoped;

/**
 *
 */
@ConversationScoped
public class SomeConversationScopedBean implements Serializable {

    private String value;

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
