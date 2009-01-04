��          �      l      �  �  �  s  h     �
  7  �
  :   *  �   e  �   ;  4   0    e  &   m     �  �   �  �   �  �   �    	       �   1  �   �  �   }  i     @  y  �  �  s  A     �  =  �  [   !  �   j!  �   @"  .   %#     T#  "   u$     �$    �$     �%  �   �&    ]'     v(  �   �(  �   V)  �   �)  i   q*                
                                                                        	          <![CDATA[public interface EjbDescriptor<T> {
   
   /**
    * Gets the EJB type
    * 
    * @return The EJB Bean class
    */
   public Class<T> getType();

   /**
    * Gets the local business interfaces of the EJB
    * 
    * @return An iterator over the local business interfaces
    */
   public Iterable<BusinessInterfaceDescriptor<?>> getLocalBusinessInterfaces();
   
   /**
    * Gets the remote business interfaces of the EJB
    * 
    * @return An iterator over the remote business interfaces
    */
   public Iterable<BusinessInterfaceDescriptor<?>> getRemoteBusinessInterfaces();
   
   /**
    * Get the remove methods of the EJB
    * 
    * @return An iterator over the remove methods
    */
   public Iterable<Method> getRemoveMethods();

   /**
    * Indicates if the bean is stateless
    * 
    * @return True if stateless, false otherwise
    */
   public boolean isStateless();

   /**
    * Indicates if the bean is a EJB 3.1 Singleton
    * 
    * @return True if the bean is a singleton, false otherwise
    */
   public boolean isSingleton();

   /**
    * Indicates if the EJB is stateful
    * 
    * @return True if the bean is stateful, false otherwise
    */
   public boolean isStateful();

   /**
    * Indicates if the EJB is and MDB
    * 
    * @return True if the bean is an MDB, false otherwise
    */
   public boolean isMessageDriven();

   /**
    * Gets the EJB name
    * 
    * @return The name
    */
   public String getEjbName();
   
   /**
    * @return The JNDI string which can be used to lookup a proxy which 
    * implements all local business interfaces 
    * 
    */
   public String getLocalJndiName();
   
}]]> <![CDATA[public interface WebBeanDiscovery {
   /**
    * Gets list of all classes in classpath archives with web-beans.xml files
    * 
    * @return An iterable over the classes 
    */
   public Iterable<Class<?>> discoverWebBeanClasses();
   
   /**
    * Gets a list of all web-beans.xml files in the app classpath
    * 
    * @return An iterable over the web-beans.xml files 
    */
   public Iterable<URL> discoverWebBeansXml();
   
   /**
    * Gets a descriptor for each EJB in the application
    * 
    * @return The bean class to descriptor map 
    */
   public Iterable<EjbDescriptor<?>> discoverEjbs();
   
}]]> Classloader isolation Currently the Web Beans RI only runs in JBoss AS 5; integrating the RI into other EE environments (for example another application server like Glassfish), into a servlet container (like Tomcat), or with an Embedded EJB3.1 implementation is fairly easy. In this Appendix we will briefly discuss the steps needed. Currently, the only SPI to implement is the bootstrap spi: If you are integrating the Web Beans into an environment that supports deployment of applications, you must enable, automatically, or through user configuation, classloader isolation for each Web Beans application If you are integrating the Web Beans into an environment that supports deployment of applications, you must insert the <literal>webbeans-ri.jar</literal> into the applications isolated classloader. It cannot be loaded from a shared classloader. Integrating the Web Beans RI into other environments It should be possible to run Web Beans in an SE environment, but you'll to do more work, adding your own contexts and lifecycle. The Web Beans RI currently doesn't expose lifecycle extension points, so you would have to code directly against Web Beans RI classes. The <literal>webbeans-ri.jar</literal> The Web Beans RI SPI The Web Beans RI also delegates EJB3 bean discovery to the container so that it doesn't have to scan for EJB3 annotations or parse <literal>ejb-jar.xml</literal>. For each EJB in the application an EJBDescriptor should be discovered: The Web Beans RI can be told to load your implementation of <literal>WebBeanDiscovery</literal> using the property <literal>org.jboss.webbeans.bootstrap.webBeanDiscovery</literal> with the fully qualified class name as the value. For example: The Web Beans SPI is located in <literal>webbeans-ri-spi</literal> module, and packaged as <literal>webbeans-ri-spi.jar</literal>. The contract described the JavaDoc is enough to implement an EJBDescriptor. In addition to these two interfaces, there is <literal>BusinessInterfaceDescriptor</literal> which represents a local business interface (encapsulating the interface class and jndi name). The contract with the container The discovery of Web Bean classes and <literal>web-bean.xml</literal> files is self-explanatory (the algorithm is described in Section 11.1 of the JSR-299 specification, and isn't repeated here). The property can either be specified as a system property, or in a properties file <literal>META-INF/web-beans-ri.properties</literal>. There are a number of requirements that the Web Beans RI places on the container for correct functioning that fall outside implementation of APIs org.jboss.webbeans.bootstrap.webBeanDiscovery=org.jboss.webbeans.integration.jbossas.WebBeanDiscoveryImpl Project-Id-Version: master.xml
Report-Msgid-Bugs-To: http://bugs.kde.org
POT-Creation-Date: 2009-01-04 23:18+0000
PO-Revision-Date: 2009-01-05 00:28+0100
Last-Translator: Nicola Benaglia <nico.benaz@gmail.com>
Language-Team: none
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
 <![CDATA[public interface EjbDescriptor<T> {
   
   /**
    * Gets the EJB type
    * 
    * @return The EJB Bean class
    */
   public Class<T> getType();

   /**
    * Gets the local business interfaces of the EJB
    * 
    * @return An iterator over the local business interfaces
    */
   public Iterable<BusinessInterfaceDescriptor<?>> getLocalBusinessInterfaces();
   
   /**
    * Gets the remote business interfaces of the EJB
    * 
    * @return An iterator over the remote business interfaces
    */
   public Iterable<BusinessInterfaceDescriptor<?>> getRemoteBusinessInterfaces();
   
   /**
    * Get the remove methods of the EJB
    * 
    * @return An iterator over the remove methods
    */
   public Iterable<Method> getRemoveMethods();

   /**
    * Indicates if the bean is stateless
    * 
    * @return True if stateless, false otherwise
    */
   public boolean isStateless();

   /**
    * Indicates if the bean is a EJB 3.1 Singleton
    * 
    * @return True if the bean is a singleton, false otherwise
    */
   public boolean isSingleton();

   /**
    * Indicates if the EJB is stateful
    * 
    * @return True if the bean is stateful, false otherwise
    */
   public boolean isStateful();

   /**
    * Indicates if the EJB is and MDB
    * 
    * @return True if the bean is an MDB, false otherwise
    */
   public boolean isMessageDriven();

   /**
    * Gets the EJB name
    * 
    * @return The name
    */
   public String getEjbName();
   
   /**
    * @return The JNDI string which can be used to lookup a proxy which 
    * implements all local business interfaces 
    * 
    */
   public String getLocalJndiName();
   
}]]> <![CDATA[public interface WebBeanDiscovery {
   /**
    * Gets list of all classes in classpath archives with web-beans.xml files
    * 
    * @return An iterable over the classes 
    */
   public Iterable<Class<?>> discoverWebBeanClasses();
   
   /**
    * Gets a list of all web-beans.xml files in the app classpath
    * 
    * @return An iterable over the web-beans.xml files 
    */
   public Iterable<URL> discoverWebBeansXml();
   
   /**
    * Gets a descriptor for each EJB in the application
    * 
    * @return The bean class to descriptor map 
    */
   public Iterable<EjbDescriptor<?>> discoverEjbs();
   
}]]> Isolamento del classloader Attualmente Web Bean RI funziona solo in JBoss AS 5; l'integrazione di RI in altri ambienti EE (per esempio in un application server come Glassfish), in un servlet container (come Tomcat), o con un'implementazione EJB3.1 Embedded è abbastanza facile. In questo appendice si discuterà brevemente dei passi necessari. Attualmente l'unico SPI (Service Provider Interface) da implementare è l'spi di bootstrap: Se si integra Web Beans in un ambiente che supporta il deploy di applicazioni, occorre abilitare, automaticamente o attraverso la configurazione utente, l'isolamento del classloader for ogni applicazione Web Beans Se si integra Web Beans in un ambiente che supporta il deploy di applicazioni, occorre inserire <literal>webbeans-ri.jar</literal> nel classloader isolato delle applicazioni. Non può essere caricato da un classloader condiviso. Integrazione di Web Beans RI in altri ambienti Dovrebbe essere possibile far funzionare Web Beans in un ambiente SE, ma occorre molto lavoro per aggiungere i propri contesti ed il ciclo di vita. Web Beans RI attualmemnte non espone punti di estensione del ciclo di vita, così occorre codificare direttamente nelle classi Web Beans RI. <literal>webbeans-ri.jar</literal> Web Beans RI SPI Web Beans RI delega al container la rilevazione dei bean EJB3 così da non essere necessario eseguire lo scan delle annotazioni EJB3 o fare il parsing di <literal>ejb-jar.xml</literal>. Per ciascun EJB nell'applicazione dovrebbe essere rilevato un EJBDescriptor: Web Beans RI può essere istruita a caricare la propria implementazione di <literal>WebBeanDiscovery</literal> usando la proprietà <literal>org.jboss.webbeans.bootstrap.webBeanDiscovery</literal> con il nome della classe pienamente qualificato (fully qualified) come valore. Per esempio: Web Beans SPI è collocato nel modulo <literal>webbeans-ri-spi</literal>, ed è impacchettato come <literal>webbeans-ri-spi.jar</literal>." Il contratto descritto in JavaDoc è sufficiente per implementare un EJBDescriptor. In aggiunta a queste due interfacce, vi è <literal>BusinessInterfaceDescriptor</literal> a rappresentare un'interfaccia locale di business (che incapsula la classe d'interfaccia ed il nome jndi). Il contratto con il container L'analisi dei file delle classi Web Bean e di <literal>web-bean.xml</literal> è molto istruttiva (l'algoritmo è descritto nella sezione 11.1 della specifica JSR-299 e non viene qua ripetuto). La proprietà può essere specificata come proprietà di sistema o nel file di proprietà <literal>META-INF/web-beans-ri.properties</literal>. Ci sono un numero di requisiti che Web Beans RI pone nel container per il corretto funzionamento al di fuori dell'implementazione delle API org.jboss.webbeans.bootstrap.webBeanDiscovery=org.jboss.webbeans.integration.jbossas.WebBeanDiscoveryImpl 