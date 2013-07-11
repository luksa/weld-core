package org.jboss.weld.tests.contexts.conversation.timeout;

import java.net.URL;

import com.gargoylesoftware.htmlunit.TextPage;
import com.gargoylesoftware.htmlunit.WebClient;
import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.container.test.api.RunAsClient;
import org.jboss.arquillian.junit.Arquillian;
import org.jboss.arquillian.test.api.ArquillianResource;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.jboss.shrinkwrap.api.asset.EmptyAsset;
import org.jboss.shrinkwrap.api.spec.WebArchive;
import org.jboss.weld.tests.category.Integration;
import org.junit.Test;
import org.junit.experimental.categories.Category;
import org.junit.runner.RunWith;

/**
 * @author Marko Luksa
 */
@RunWith(Arquillian.class)
@Category(Integration.class)
public class ConversationTimeoutTest {

    @ArquillianResource
    private URL url;

    @Deployment(testable = false)
    public static WebArchive getDeployment() {
        return ShrinkWrap.create(WebArchive.class)
                .addPackage(ConversationTimeoutTest.class.getPackage())
                .addAsWebInfResource(EmptyAsset.INSTANCE, "beans.xml");
    }

    @Test
    @RunAsClient
    public void testConversationDoesNotExpireDuringRedirect() throws Exception {
        WebClient client = new WebClient();

        TextPage page = client.getPage(url + "/servlet/beginConversation");
        String cid = page.getContent();

        Thread.sleep(1000); // wait for conversation to time out

        page = client.getPage(url + "/servlet/testConversation?cid=" + cid);    // initial request after expiration
        page = client.getPage(url + "/servlet/testConversation?cid=" + cid);    // simulate a redirect
    }

}
