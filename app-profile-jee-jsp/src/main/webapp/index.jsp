<!--
JBoss, Home of Professional Open Source
Copyright 2016, Red Hat, Inc. and/or its affiliates, and individual
contributors by the @authors tag. See the copyright.txt in the
distribution for a full listing of individual contributors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

<%@page contentType="text/html" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>Keycloak Example App</title>

    <link rel="stylesheet" type="text/css" href="styles.css"/>

    <script>
        function redirectToProfile() {
            var scope = 'openid'

            if (document.getElementById('displayPhone').checked) {
                scope = scope + ' phone';
            }

            if (document.getElementById('displayAddress').checked) {
                scope = scope + ' address';
            }

            if (document.getElementById('serviceAudience').checked) {
                scope = scope + ' service';
            }

            var link = 'profile.jsp?scope=' + scope;
            location.href = link;
        };
    </script>
</head>
<body>
<jsp:useBean id="controller" class="org.keycloak.quickstart.profilejee.Controller" scope="request"/>
<% controller.handleLogout(request); %>

<c:set var="isLoggedIn" value="<%=controller.isLoggedIn(request)%>"/>
<c:if test="${isLoggedIn}">
    <c:redirect url="profile.jsp"/>
</c:if>

<div class="wrapper" id="welcome">

    <div class="content">
        <table>
            <tr><td width="30%">Display phone?</td><td><input id="displayPhone" type="checkbox" /></td></tr>
            <tr><td width="30%">Display address?</td><td><input id="displayAddress" type="checkbox" /></td></tr>
             <tr><td width="30%">Has service audience?</td><td><input id="serviceAudience" type="checkbox" /></td></tr>
        </table>
    </div>

    <div class="menu">
        <button name="loginBtn" onclick="redirectToProfile()" type="button">Login</button>
    </div>

    <div class="content">
        <div class="message">Please login</div>
    </div>
</div>
</body>
</html>
