<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xsi:schemaLocation="
		http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
		http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-3.0.xsd">	

	<!-- Configures the @Controller programming model -->
	<mvc:annotation-driven />
	<mvc:view-controller path="/" view-name="welcome" />
	<mvc:view-controller path="/error" view-name="error"/>
	<mvc:view-controller path="/accessDenied" view-name="accessDenied"/>
	
	<!-- Configures Handler Interceptors -->	
	<mvc:interceptors>
		<!-- Changes the locale when a 'locale' request parameter is sent; e.g. /?locale=de -->
		<bean class="org.springframework.web.servlet.i18n.LocaleChangeInterceptor" />
	</mvc:interceptors>

	<!-- Saves a locale change using a cookie -->
	<bean id="localeResolver" class="org.springframework.web.servlet.i18n.CookieLocaleResolver" >
		<property name="cookieName"><value>language</value></property>
	</bean>
	<bean id="tilesConfigurer" class="org.springframework.web.servlet.view.tiles2.TilesConfigurer">
		<property name="definitions">
			<list>
				<value>/WEB-INF/views/tiles.xml</value>
			</list>
		</property>
	</bean>
  	<bean id="viewResolver" class="org.springframework.web.servlet.view.UrlBasedViewResolver">
        <property name="viewClass" value="org.springframework.web.servlet.view.tiles2.TilesView"/>
    </bean>
    
	<!-- Web Module Message Bundle -->
    <bean id="messageSource" class="org.springframework.context.support.ReloadableResourceBundleMessageSource">
    	<property name="parentMessageSource" ref="appMessageSource" />
        <property name="basename" value="/WEB-INF/resources/${warNameShort}.i18n" />
		<property name="defaultEncoding" value="UTF-8"/>
    </bean>
</beans>