<#-- 
 -- Copyright 2013 E.J.I.E., S.A.
 --
 -- Licencia con arreglo a la EUPL, Versión 1.1 exclusivamente (la «Licencia»);
 -- Solo podrá usarse esta obra si se respeta la Licencia.
 -- Puede obtenerse una copia de la Licencia en
 --
 --      http://ec.europa.eu/idabc/eupl.html
 --
 -- Salvo cuando lo exija la legislación aplicable o se acuerde por escrito, 
 -- el programa distribuido con arreglo a la Licencia se distribuye «TAL CUAL»,
 -- SIN GARANTÍAS NI CONDICIONES DE NINGÚN TIPO, ni expresas ni implícitas.
 -- Véase la Licencia en el idioma concreto que rige los permisos y limitaciones
 -- que establece la Licencia.
 -->
<?xml version="1.0" encoding="utf-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:p="http://www.springframework.org/schema/p"
	xmlns:context="http://www.springframework.org/schema/context"
	xsi:schemaLocation="
		http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans-3.2.xsd 
		http://www.springframework.org/schema/mvc 
		http://www.springframework.org/schema/mvc/spring-mvc-3.2.xsd 
		http://www.springframework.org/schema/context 
		http://www.springframework.org/schema/context/spring-context-3.2.xsd">

	<!-- Crea un bean por cada clase anotada con @Component en el paquete 'com.ejie.${codapp}.control' -->
	<context:component-scan base-package="com.ejie.${codapp}.control" />

	<!-- Mapeos directos -->
	<mvc:view-controller path="/" view-name="welcome" />
	<mvc:view-controller path="/error" view-name="error" />
	<mvc:view-controller path="/accessDenied" view-name="accessDenied" />
	<mvc:view-controller path="/mockLoginPage" view-name="mockLoginPage" />
	<mvc:view-controller path="/mockLoginAjaxPage" view-name="mockLoginAjaxPage" />

	<!-- Filtro utilizado para emular el comportamiento de los mensajes de error 
		http en peticiones realizadas desde iframes -->
	<bean id="iframeXHREmulationFilter" class="com.ejie.x38.IframeXHREmulationFilter" />

 	<!-- Recursos idiomáticos (i18n) -->
	<bean id="messageSource" class="org.springframework.context.support.ReloadableResourceBundleMessageSource">
		<property name="parentMessageSource" ref="appMessageSource" />
		<property name="basename" value="/WEB-INF/resources/${warNameShort}.i18n" />
		<property name="defaultEncoding" value="UTF-8" />
		<property name="useCodeAsDefaultMessage" value="true" />
        <property name="fallbackToSystemLocale" value="false" />
	</bean>

	<!-- Gestiona la locale (idioma) mediante cookie  -->
    <bean id="localeResolver" class="org.springframework.web.servlet.i18n.CookieLocaleResolver">
        <property name="cookieName" value="language" />
    </bean>
    
    <!-- Gestiona las propiedades del WAR: idioma (cuando se envía el parametro 'locale' en la request '/?locale=en'), layout, idioma disponible... -->
    <bean id="mvcInterceptor" class="com.ejie.x38.control.MvcInterceptor" >
		<!-- <property name="paramName" value="locale" /> -->
       	<property name="defaultLanguage" value="${defaultlanguage}" />
       	<property name="defaultLayout" value="${layout}" />
       	<property name="availableLangs" value="${languageswithoutquotes}" />
		<!-- <property name="portalCookie" value="r01euskadiCookie" /> -->
     </bean>

	<!-- Declaración del interceptor (Gestión idomática) -->
    <mvc:interceptors>
         <ref bean="mvcInterceptor"/>
    </mvc:interceptors>

    <!-- Configurar Excepciones propagadas en los Controller -->
	<bean class="com.ejie.x38.control.exception.MvcExceptionResolverConfig">
<!-- 		<property name="handlers"> -->
<!-- 			<list> -->
<!-- 				<bean class="MyExceptionHandler" /> -->
<!-- 			</list> -->
<!-- 		</property> -->
	</bean>
	<!-- Configurar Excepcion de límite de subida de ficheros -->
	<bean id="fileExceedsFileSizeLimitHandler" class="com.ejie.x38.control.exception.FileExceedsFileSizeLimitHandler" />
	
	<!-- Configurar Validaciones -->
	<bean id="validator" class="org.springframework.validation.beanvalidation.LocalValidatorFactoryBean" >
		<property name="validationMessageSource" ref="messageSource"/>
	</bean>
    
    <!-- Configuracion Converters -->
	<bean id="conversionService" class="org.springframework.context.support.ConversionServiceFactoryBean">
		<property name="converters">
			<list>
				<!-- Converter para el tratamiento de las fechas -->
				<bean class="com.ejie.x38.converter.DateConverter" />
			</list>
		</property>
	</bean>

	<!-- Configurar MVC -->
	    <bean class="org.springframework.web.servlet.mvc.annotation.DefaultAnnotationHandlerMapping">
	        <property name="order" value="1" />
	    </bean>
	    
		<!-- Permite la subida de ficheros -->	
		<bean id="multipartResolver" class="com.ejie.x38.util.UdaMultipartResolver" >
			<property name="maxUploadSize" value="10000" />
		</bean>
		
	    <!-- Bean encargado de las peticiones -->
	    <bean id="requestMappingHandlerAdapter" class="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter">
		    <property name="webBindingInitializer">
		        <bean class="org.springframework.web.bind.support.ConfigurableWebBindingInitializer">
		            <property name="conversionService" ref="conversionService" />
		        	<property name="validator" ref="validator" />
		    	</bean>
		    </property>
	       	<property name="messageConverters">
	            <list>
	            	<ref bean="udaMappingJackson2HttpMessageConverter"/>
	            </list>
       		</property>
       		<property name="customArgumentResolvers">
       			<list>
	            	<bean class="com.ejie.x38.control.method.annotation.RequestJsonBodyMethodArgumentResolver"/>
	            </list>
	        </property>
		</bean>
	<!-- FIN -->
		
	<!-- Gestión de la Vista (View) -->
    <bean id="tilesConfigurer" class="org.springframework.web.servlet.view.tiles2.TilesConfigurer">
        <property name="definitions">
            <list>
                <value>/WEB-INF/views/tiles.xml</value>
            </list>
        </property>
    </bean>
	<bean id="viewResolver" class="com.ejie.x38.control.view.UdaViewResolver">
        <property name="viewClass" value="com.ejie.x38.control.view.UdaTilesView"/>
        <property name="exposedContextBeanNames">
        	<list>
        		<value>localeResolver</value>
        		<value>mvcInterceptor</value>
        		<value>udaAuthenticationProvider</value>
        	</list>
        </property>
    </bean> 
	
	<!-- Reports -->	
<!--	<bean class="org.springframework.web.servlet.view.XmlViewResolver"> -->
<!-- 	   <property name="location"> -->
<!-- 	       <value>/WEB-INF/spring/reports-config.xml</value> -->
<!-- 	   </property> -->
<!-- 	   <property name="order" value="0" /> -->
<!--	</bean> -->
</beans>