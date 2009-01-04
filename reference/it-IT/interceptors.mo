��    E      D  a   l      �  i   �  K   [  �   �  �   �  �   *  r   �  �   :	  c   �	  Z   4
  <   �
  �   �
  }   m  c   �  c   O  N   �  �     b   �  J   #  �   n  c   �  [   _  �   �  �   @  u   �  �   7  Q   �  �     ;   �  �   4        d     v   {  p   �  7   c     �  $   �     �  !   �       (     @   G  ]   �  N   �  �   5  7   �  G   %  b   m  �   �  %  �  �   �  ?   ^  }   �  H     '   e    �  g   �  o     �   t  7  E  .   }   "   �   !   �   ?   �   v   1!  D   �!      �!  =   "  ~   L"  @  �"  i   $  K   v$  �   �$  �   �%  �   E&  r   �&  �   U'  c   �'  Z   O(  <   �(  �   �(  }   �)  c   *  c   j*  N   �*  �   +  b   �+  J   >,  �   �,  c   -  [   z-  �   �-  �   [.  �   �.  �   �/  h   0  �   �0  C   t1  �   �1     �2  `   �2  �   
3  �   �3  6   4     J4  -   g4     �4     �4     �4  ,   �4  H   5  h   O5  [   �5  �   6  B   �6  M   67  n   �7  �   �7  �   �8  �   �9  F   ^:  �   �:  E   (;  '   n;     �;  m   �<  s   %=  �   �=  ;  h>  *   �?  M   �?  )   @  O   G@  �   �@  P   A  1   oA  I   �A  �   �A     8       =          !                 6      9           4   B          
                     1   ;                  #              %      >       '   5   .                    3                          @   /       $   -   ?   )           *   A   (   &   C                	             "   <         ,           7      0       2      :          E   +   D    <![CDATA[<Interceptors>
    <sx:SecurityInterceptor/>
    <tx:TransactionInterceptor/>
</Interceptors>]]> <![CDATA[<Interceptors>
    <tx:TransactionInterceptor/>
</Interceptors>]]> <![CDATA[@ApplicationScoped @Transactional @Interceptor
public class TransactionInterceptor {

    @Resource Transaction transaction;

    @AroundInvoke public Object manageTransaction(InvocationContext ctx) { ... }
    
}]]> <![CDATA[@InterceptorBindingType
@Target({METHOD, TYPE})
@Retention(RUNTIME)
public @interface Secure {
    @NonBinding String[] rolesAllowed() default {};
}]]> <![CDATA[@InterceptorBindingType
@Target({METHOD, TYPE})
@Retention(RUNTIME)
public @interface Transactional {
    boolean requiresNew() default false;
}]]> <![CDATA[@InterceptorBindingType
@Target({METHOD, TYPE})
@Retention(RUNTIME)
public @interface Transactional {}]]> <![CDATA[@Interceptors({TransactionInterceptor.class, SecurityInterceptor.class})
public class ShoppingCart {
    public void checkout() { ... }
}]]> <![CDATA[@Secure
public class ShoppingCart {
    @Transactional public void checkout() { ... }
}]]> <![CDATA[@Secure(rolesAllowed="admin") @Transactional
public class ShoppingCart { ... }]]> <![CDATA[@Transactional
public class ShoppingCart { ... }]]> <![CDATA[@Transactional @Interceptor
public class TransactionInterceptor {
    @AroundInvoke public Object manageTransaction(InvocationContext ctx) { ... }
}]]> <![CDATA[@Transactional @Secure
@InterceptorBindingType
@Target(TYPE)
@Retention(RUNTIME)
public @interface Action { ... }]]> <![CDATA[@Transactional @Secure
public class ShoppingCart {
    public void checkout() { ... }
}]]> <![CDATA[@Transactional @Secure @Interceptor
public class TransactionalSecureInterceptor { ... }]]> <![CDATA[@Transactional(requiresNew=true)
public class ShoppingCart { ... }]]> <![CDATA[@Transactional(requiresNew=true) @Interceptor
public class RequiresNewTransactionInterceptor {
    @AroundInvoke public Object manageTransaction(InvocationContext ctx) { ... }
}]]> <![CDATA[@Transactionl
public class ShoppingCart {
    @Secure public void checkout() { ... }
}]]> <![CDATA[public @interface Action extends Transactional, Secure { ... }]]> <![CDATA[public class DependencyInjectionInterceptor {
    @PostConstruct public void injectDependencies(InvocationContext ctx) { ... }
}]]> <![CDATA[public class ShoppingCart {
    @Transactional @Secure public void checkout() { ... }
}]]> <![CDATA[public class ShoppingCart {
    @Transactional public void checkout() { ... }
}]]> <![CDATA[public class TransactionInterceptor {
    @AroundInvoke public Object manageTransaction(InvocationContext ctx) { ... }
}]]> A <emphasis>business method interceptor</emphasis> applies to invocations of methods of the Web Bean by clients of the Web Bean: A <emphasis>lifecycle callback interceptor</emphasis> applies to invocations of lifecycle callbacks by the container: All Web Beans interceptors are simple Web Beans, and can take advantage of dependency injection and contextual lifecycle management. An interceptor class may intercept both lifecycle callbacks and business methods. Any Web Bean annotated <literal>@Action</literal> will be bound to both <literal>TransactionInterceptor</literal> and <literal>SecurityInterceptor</literal>. (And even <literal>TransactionalSecureInterceptor</literal>, if it exists.) Any Web Bean may have interceptors, not just session beans. But what if we only have one interceptor and we want the manager to ignore the value of <literal>requiresNew</literal> when binding interceptors? We can use the <literal>@NonBinding</literal> annotation: Enabling interceptors Finally, we need to <emphasis>enable</emphasis> our interceptor in <literal>web-beans.xml</literal>. For example, we could specify that our security interceptor runs before our <literal>TransactionInterceptor</literal>. However, in very complex cases, an interceptor itself may specify some combination of interceptor binding types: However, this approach suffers the following drawbacks: Implementing interceptors Interceptor binding type inheritance Interceptor bindings Interceptor bindings with members Interceptors Multiple interceptor binding annotations Multiple interceptors may use the same interceptor binding type. Now we can easily specify that our <literal>ShoppingCart</literal> is a transactional object: Now we can use <literal>RequiresNewTransactionInterceptor</literal> like this: One limitation of the Java language support for annotations is the lack of annotation inheritance. Really, annotations should have reuse built in, to allow this kind of thing to work: Or we could turn them both off in our test environment! Or, if we prefer, we can specify that just one method is transactional: Suppose we want to add some extra information to our <literal>@Transactional</literal> annotation: Suppose we want to declare that some of our Web Beans are transactional. The first thing we need is an <emphasis>interceptor binding annotation</emphasis> to specify exactly which Web Beans we're interested in: That's great, but somewhere along the line we're going to have to actually implement the interceptor that provides this transaction management aspect. All we need to do is create a standard EJB interceptor, and annotate it <literal>@Interceptor</literal> and <literal>@Transactional</literal>. The <literal>@Interceptors</literal> annotation defined by the EJB specification is supported for both enterprise and simple Web Beans, for example: The EJB specification defines two kinds of interception points: Then this interceptor could be bound to the <literal>checkout()</literal> method using any one of the following combinations: Therefore, we recommend the use of Web Beans-style interceptor bindings. Use of <literal>@Interceptors</literal> Usually we use combinations of interceptor bindings types to bind multiple interceptors to a Web Bean. For example, the following declaration would be used to bind <literal>TransactionInterceptor</literal> and <literal>SecurityInterceptor</literal> to the same Web Bean: Web Beans features a more sophisticated annotation-based approach to binding interceptors to Web Beans. Web Beans re-uses the basic interceptor architecture of EJB 3.0, extending the functionality in two directions: Web Beans will use the value of <literal>requiresNew</literal> to choose between two different interceptors, <literal>TransactionInterceptor</literal> and <literal>RequiresNewTransactionInterceptor</literal>. Well, fortunately, Web Beans works around this missing feature of Java. We may annotate one interceptor binding type with other interceptor binding types. The interceptor bindings are transitive&#151;any Web Bean with the first interceptor binding inherits the interceptor bindings declared as meta-annotations. Well, the XML declaration solves two problems: Whoah! Why the angle bracket stew? business method interception, and interceptors may not be easily disabled at deployment time, and it enables us to specify a total ordering for all the interceptors in our system, ensuring deterministic behavior, and it lets us enable or disable interceptor classes at deployment time. lifecycle callback interception. the interceptor implementation is hardcoded in business code, the interceptor ordering is non-global&#151;it is determined by the order in which interceptors are listed at the class level. Project-Id-Version: master.xml
Report-Msgid-Bugs-To: http://bugs.kde.org
POT-Creation-Date: 2009-01-04 23:18+0000
PO-Revision-Date: 2009-01-05 00:26+0100
Last-Translator: Nicola Benaglia <nico.benaz@gmail.com>
Language-Team: none
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
 <![CDATA[<Interceptors>
    <sx:SecurityInterceptor/>
    <tx:TransactionInterceptor/>
</Interceptors>]]> <![CDATA[<Interceptors>
    <tx:TransactionInterceptor/>
</Interceptors>]]> <![CDATA[@ApplicationScoped @Transactional @Interceptor
public class TransactionInterceptor {

    @Resource Transaction transaction;

    @AroundInvoke public Object manageTransaction(InvocationContext ctx) { ... }
    
}]]> <![CDATA[@InterceptorBindingType
@Target({METHOD, TYPE})
@Retention(RUNTIME)
public @interface Secure {
    @NonBinding String[] rolesAllowed() default {};
}]]> <![CDATA[@InterceptorBindingType
@Target({METHOD, TYPE})
@Retention(RUNTIME)
public @interface Transactional {
    boolean requiresNew() default false;
}]]> <![CDATA[@InterceptorBindingType
@Target({METHOD, TYPE})
@Retention(RUNTIME)
public @interface Transactional {}]]> <![CDATA[@Interceptors({TransactionInterceptor.class, SecurityInterceptor.class})
public class ShoppingCart {
    public void checkout() { ... }
}]]> <![CDATA[@Secure
public class ShoppingCart {
    @Transactional public void checkout() { ... }
}]]> <![CDATA[@Secure(rolesAllowed="admin") @Transactional
public class ShoppingCart { ... }]]> <![CDATA[@Transactional
public class ShoppingCart { ... }]]> <![CDATA[@Transactional @Interceptor
public class TransactionInterceptor {
    @AroundInvoke public Object manageTransaction(InvocationContext ctx) { ... }
}]]> <![CDATA[@Transactional @Secure
@InterceptorBindingType
@Target(TYPE)
@Retention(RUNTIME)
public @interface Action { ... }]]> <![CDATA[@Transactional @Secure
public class ShoppingCart {
    public void checkout() { ... }
}]]> <![CDATA[@Transactional @Secure @Interceptor
public class TransactionalSecureInterceptor { ... }]]> <![CDATA[@Transactional(requiresNew=true)
public class ShoppingCart { ... }]]> <![CDATA[@Transactional(requiresNew=true) @Interceptor
public class RequiresNewTransactionInterceptor {
    @AroundInvoke public Object manageTransaction(InvocationContext ctx) { ... }
}]]> <![CDATA[@Transactionl
public class ShoppingCart {
    @Secure public void checkout() { ... }
}]]> <![CDATA[public @interface Action extends Transactional, Secure { ... }]]> <![CDATA[public class DependencyInjectionInterceptor {
    @PostConstruct public void injectDependencies(InvocationContext ctx) { ... }
}]]> <![CDATA[public class ShoppingCart {
    @Transactional @Secure public void checkout() { ... }
}]]> <![CDATA[public class ShoppingCart {
    @Transactional public void checkout() { ... }
}]]> <![CDATA[public class TransactionInterceptor {
    @AroundInvoke public Object manageTransaction(InvocationContext ctx) { ... }
}]]> Un <emphasis>interceptor di un metodo di business</emphasis> si applica alle invocazioni di metodi del Web Bean da parte di client del Web Bean: Un <emphasis>interceptor di chiamata del ciclo di vita</emphasis> si applica alle invocazioni delle chiamate del ciclo di vita da parte del container: Tutti gli interceptor dei Web Beans sono Web Beans semplici e possono sfruttare la dependency injection e la gestione del ciclo di vita contestuale. Una classe interceptor può intercettare entrambi le chiamate del ciclo di vita ed i metodi di business. Ogni Web Bean annotato con <literal>@Action</literal> verrà legato ad entrambi <literal>TransactionInterceptor</literal> e <literal>SecurityInterceptor</literal>. (E anche <literal>TransactionalSecureInterceptor</literal>, se questo esiste.) Qualsiasi Web Bean può avere interceptor, non solo i session bean. Ma cosa succede se si ha solo un interceptor e si vuole che il manager ignori il valore di <literal>requiresNew</literal> quando si associa l'interceptor? Si può usare l'annotazione <literal>@NonBinding</literal>: Abilitare gli interceptor Infine occorre <emphasis>abilitare</emphasis> l'interceptor in <literal>web-beans.xml</literal>. Per esempio è possibile specificare che l'interceptor di sicurezza venga eseguito prima di <literal>TransactionInterceptor</literal>." Comunque in casi molto complessi un interceptor da solo potrebbe specificare alcune combinazioni di tipi di interceptor binding: Comunque, quest'approccio soffre dei seguenti difetti: Implementare gli interceptor Ereditarietà del tipo di interceptor binding Interceptor bindings Interceptor binding con membri Gli interceptor Annotazioni per interceptor binding multipli Diverso interceptor possono usare lo stesso tipo di interceptor binding. Ora è facilmente possibile specificare che <literal>ShoppingCart</literal> è un oggetto transazionale: Ora è possibile usare <literal>RequiresNewTransactionInterceptor</literal> in questo modo: Una limitazione del supporto del linguaggio Java per le annotazioni è la mancanza di ereditarietà delle annotazioni. In verità le annotazioni dovrebbero avere il riutilizzo predefinito per consentire che questo avvenga: Oppure si può disattivarli entrambi dal proprio ambiente di test! O se si preferisce, si può specificare che solo un metodo sia transazionale: Si supponga di voler aggiungere qualche informazione extra all'annotazione  <literal>@Transactional</literal>: Si supponga di voler dichiarare transazionali alcuni Web Beans. La prima cosa necessaria è un'<emphasis>annotazione di interceptor binding</emphasis> per specificare esattamente quali Web Beans sono interessati: Bene, ma da qualche parte è necessario implementare l'interceptor che fornisce l'aspect di gestione della transazione. Occore quindi creare un interceptor EJB standard e annotarlo con <literal>@Interceptor</literal> e <literal>@Transactional</literal>." L'annotazione <literal>@Interceptors</literal> definita dalla specifica EJB è supportata per entrambi i Web Bean semplici ed enterprise, per esempio: "La specifica Web Bean definisce due tipi di punti di intercettazione: Allora quest'interceptor potrebbe venire associato al metodo <literal>checkout()</literal> usando una delle seguenti combinazioni: Quindi si raccomanda l'uso di interceptor binding di stile Web Beans. Uso di <literal>@Interceptors</literal> Solitamente si usano combinazioni di tipi di interceptor binding per associare pià interceptor ad un Web Bean. Per esempio, la seguente dichiarazione verrebbe impiegata per associare <literal>TransactionInterceptor</literal> e <literal>SecurityInterceptor</literal> allo stesso Web Bean: Web Bean fornisce un più sofisticato approccio basato su annotazioni per associare interceptor ai Web Beans. Web Beans riutilizza l'architettura base degli interceptor di EJB3.0, estendendo la funzionalità in due direzioni: Web Beans utilizzerà il valore di <literal>requiresNew</literal> per scegliere tra due diversi interceptor, <literal>TransactionInterceptor</literal> e <literal>RequiresNewTransactionInterceptor</literal>. Fortunatamente Web Beans provvede a questa mancanza di Java. E' possibile annotare un tipo di interceptor binding con altri tipi di interceptor binding. Gli interceptor binding sono transitivi&#151;qualsiasi Web Bean con il primo interceptor binding eredita gli interceptor binding dichiarati come meta-annotazioni. La dichiarazione XML risolve due problemi: Ma perché viene usato ancora XML, quando Web Beans non dovrebbe utilizzarlo? intercettazione del metodo di business, e gli interceptor possono non essere facilmente disabilitati a deployment time, e Ci consente di specificare un ordinamento totale per tutti gli interceptor del sistema, assicurando un comportamente deterministico, e consente di abilitare o disabilitare le classi di interceptor a deployment time. intercettazione della chiamata del ciclo di vita. l'implementazione degli interceptor è codificata nel codice di business, l'ordinamento degli interceptor è non-globale&#151;è determinata dall'ordine in cui gli interceptor sono elencati al livello di classe. 