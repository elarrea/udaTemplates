<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns="http://java.sun.com/xml/ns/javaee" xmlns:web="http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd"
	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd"
	version="2.5">
	<context-param>
		<param-name>parentContextKey</param-name>
		<param-value>ear.context</param-value>
	</context-param>
	<context-param>
		<param-name>webAppName</param-name>
		<param-value>${codapp}</param-value>
	</context-param>		
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>/WEB-INF/spring/app-config.xml</param-value>
	</context-param>
	<!-- Log4j initialization Listener -->
	<listener>
		<listener-class>com.ejie.x38.UdaListener</listener-class>
	</listener>
	<!-- Core Spring Listener -->	
	<listener>
		<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
	</listener>
	<!--Support the scoping of beans at the request, session, and global session 
		levels (web-scoped beans) -->
	<listener>
		<listener-class>org.springframework.web.context.request.RequestContextListener</listener-class>
	</listener>
	<!-- Here's were some of the fundamental AOP Aspects are applied -->
	<filter>
		<filter-name>udaFilter</filter-name>
		<filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
	</filter>
	<filter-mapping>
		<filter-name>udaFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>	
	<!-- Handles Security -->
	<filter>
		<display-name>springSecurityFilterChain</display-name>
		<filter-name>springSecurityFilterChain</filter-name>
		<filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
	</filter>
	<filter-mapping>
		<filter-name>springSecurityFilterChain</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
	<!-- Validates data transparently -->
	<filter>
		<filter-name>validationFilter</filter-name>
		<filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
	</filter>
	<filter-mapping>
		<filter-name>validationFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
	<!-- Reads request input using UTF-8 encoding -->
	<filter>
		<filter-name>characterEncodingFilter</filter-name>
		<filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
		<init-param>
			<param-name>encoding</param-name>
			<param-value>UTF-8</param-value>
		</init-param>
		<init-param>
			<param-name>forceEncoding</param-name>
			<param-value>true</param-value>
		</init-param>
	</filter>
	<filter-mapping>
		<filter-name>characterEncodingFilter</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>
	<!-- Handles all requests into the application -->
	<servlet>
		<servlet-name>Spring MVC Dispatcher Servlet</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
		<init-param>
			<param-name>contextConfigLocation</param-name>
			<param-value></param-value>
		</init-param>
		<load-on-startup>1</load-on-startup>
	</servlet>
	<servlet-mapping>
		<servlet-name>Spring MVC Dispatcher Servlet</servlet-name>
		<url-pattern>/</url-pattern>
	</servlet-mapping>
	<!-- Handles data validation requests -->
	<servlet>
		<servlet-name>validationServlet</servlet-name>
		<servlet-class>org.springframework.web.context.support.HttpRequestHandlerServlet</servlet-class>
	</servlet>
	<servlet-mapping>
		<servlet-name>validationServlet</servlet-name>
		<url-pattern>/validate/*</url-pattern>
	</servlet-mapping>
</web-app>