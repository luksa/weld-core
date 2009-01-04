��          �      �       0  -  1  �  _  i   �  =  Z    �  �   �	     R
  �   n
  ;   D  @   �  �   �  E   w  @  �  -  �  �  ,  i   �  =  '    e  �   �     *  �   J  I   *  :   t  �   �  J   l                        
                              	    <![CDATA[<h:form>
    <h:panelGrid columns="2" rendered="#{!login.loggedIn}">
        <h:outputLabel for="username">Username:</h:outputLabel>
        <h:inputText id="username" value="#{credentials.username}"/>
        <h:outputLabel for="password">Password:</h:outputLabel>
        <h:inputText id="password" value="#{credentials.password}"/>
    </h:panelGrid>
    <h:commandButton value="Login" action="#{login.login}" rendered="#{!login.loggedIn}"/>
    <h:commandButton value="Logout" acion="#{login.logout}" rendered="#{login.loggedIn}"/>
</h:form>]]> <![CDATA[@Named @RequestScoped
public class Credentials {
        
    private String username;
    private String password;
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
}]]> <![CDATA[@Retention(RUNTIME)
@Target({TYPE, METHOD, FIELD})
@BindingType
public @interface LoggedIn {}]]> <![CDATA[@SessionScoped @Named
public class Login {

    @Current Credentials credentials;
    @PersistenceContext EntityManager userDatabase;

    private User user;
    
    public void login() {
            
        List<User> results = userDatabase.createQuery(
           "select u from User u where u.username=:username and u.password=:password")
           .setParameter("username", credentials.getUsername())
           .setParameter("password", credentials.getPassword())
           .getResultList();
        
        if ( !results.isEmpty() ) {
           user = results.get(0);
        }
        
    }
    
    public void logout() {
        user = null;
    }
    
    public boolean isLoggedIn() {
       return user!=null;
    }
    
    @Produces @LoggedIn User getCurrentUser() {
        return user;
    }

}]]> <![CDATA[public class DocumentEditor {

    @Current Document document;
    @LoggedIn User currentUser;
    @PersistenceContext EntityManager docDatabase;
    
    public void save() {
        document.setCreatedBy(currentUser);
        docDatabase.persist(document);
    }
    
}]]> Hopefully, this example gives a flavor of the Web Bean programming model. In the next chapter, we'll explore Web Beans dependency injection in greater depth. JSF web application example Let's illustrate these ideas with a full example. We're going to implement user login/logout for an application that uses JSF. First, we'll define a Web Bean to hold the username and password entered during login: Now, any other Web Bean can easily inject the current user: Of course, <literal>@LoggedIn</literal> is a binding annotation: The actual work is done by a session scoped Web Bean that maintains information about the currently logged-in user and exposes the <literal>User</literal> entity to other Web Beans: This Web Bean is bound to the login prompt in the following JSF form: Project-Id-Version: master.xml
Report-Msgid-Bugs-To: http://bugs.kde.org
POT-Creation-Date: 2009-01-04 23:18+0000
PO-Revision-Date: 2009-01-05 00:25+0100
Last-Translator: Nicola Benaglia <nico.benaz@gmail.com>
Language-Team: none
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
 <![CDATA[<h:form>
    <h:panelGrid columns="2" rendered="#{!login.loggedIn}">
        <h:outputLabel for="username">Username:</h:outputLabel>
        <h:inputText id="username" value="#{credentials.username}"/>
        <h:outputLabel for="password">Password:</h:outputLabel>
        <h:inputText id="password" value="#{credentials.password}"/>
    </h:panelGrid>
    <h:commandButton value="Login" action="#{login.login}" rendered="#{!login.loggedIn}"/>
    <h:commandButton value="Logout" acion="#{login.logout}" rendered="#{login.loggedIn}"/>
</h:form>]]> <![CDATA[@Named @RequestScoped
public class Credentials {
        
    private String username;
    private String password;
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
}]]> <![CDATA[@Retention(RUNTIME)
@Target({TYPE, METHOD, FIELD})
@BindingType
public @interface LoggedIn {}]]> <![CDATA[@SessionScoped @Named
public class Login {

    @Current Credentials credentials;
    @PersistenceContext EntityManager userDatabase;

    private User user;
    
    public void login() {
            
        List<User> results = userDatabase.createQuery(
           "select u from User u where u.username=:username and u.password=:password")
           .setParameter("username", credentials.getUsername())
           .setParameter("password", credentials.getPassword())
           .getResultList();
        
        if ( !results.isEmpty() ) {
           user = results.get(0);
        }
        
    }
    
    public void logout() {
        user = null;
    }
    
    public boolean isLoggedIn() {
       return user!=null;
    }
    
    @Produces @LoggedIn User getCurrentUser() {
        return user;
    }

}]]> <![CDATA[public class DocumentEditor {

    @Current Document document;
    @LoggedIn User currentUser;
    @PersistenceContext EntityManager docDatabase;
    
    public void save() {
        document.setCreatedBy(currentUser);
        docDatabase.persist(document);
    }
    
}]]> Quest'esempio è un assaggio del modello di programmazione con Web Bean. Nel prossimo capitolo esploreremo la dependency injection dei Web Bean con maggior profondità. Esempio di applicazione web JSF Illustriamo queste idee con un esempio completo. Implementiamo il login/logout dell'utente per un'applicazione che utilizza JSF. Innanzitutto definiamo un Web Bean che mantenga username e password digitati durante il login: Ora qualsiasi altro Web Bean può facilmente iniettare l'utente corrente: <literal>@LoggedIn</literal> è un'annotazione di binding: Il vero lavoro è fatto da un Web Bean con scope di sessione che mantiene le informazioni sull'utente correntemente loggato ed espone l'entity <literal>User</literal> agli altri Web Beans: Questo Web Bean è associato al login all'interno della seguente form JSF: 