package org.jboss.weld.tests.contexts.conversation.timeout;

import java.io.IOException;

import javax.enterprise.context.Conversation;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 */
@WebServlet(urlPatterns = "/servlet/*")
public class SomeServlet extends HttpServlet {

    @Inject
    private SomeBean someBean;

    @Inject
    private Conversation conversation;

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("======================");
        System.out.println(req.getPathInfo());
        System.out.println("conversation.getId() = " + conversation.getId());
        System.out.println("conversation.isTransient() = " + conversation.isTransient());
        if ("/beginConversation".equals(req.getPathInfo())) {
            String cid = someBean.beginConversation();
            resp.getWriter().print(cid);
        } else if ("/testConversation".equals(req.getPathInfo())) {
            String cid = someBean.testConversation();
            resp.getWriter().print(cid);
        }

        System.out.println("conversation.getId() = " + conversation.getId());
        System.out.println("conversation.isTransient() = " + conversation.isTransient());
    }


}
