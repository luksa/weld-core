package org.jboss.weld.tests.contexts.conversation.timeout;

import javax.enterprise.context.Conversation;
import javax.inject.Inject;

/**
 *
 */
public class SomeBean {

    @Inject
    private Conversation conversation;

    @Inject
    private SomeConversationScopedBean bean;


    public String beginConversation() {
        conversation.begin();
        conversation.setTimeout(1);

        bean.setValue("foo");
        return conversation.getId();
    }

    public String testConversation() {
        String value = bean.getValue();
        if (!"foo".equals(value)) {
            throw new IllegalStateException("bean's value was not foo");
        }
        return "";
    }
}
