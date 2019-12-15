<%--
  Created by IntelliJ IDEA.
  User: Huber
  Date: 25.11.2019
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
</head>

<body>
<nav class="navbar navbar-dark navbar-expand-md" style="background-color:#2d2d2d;color:rgb(255,255,255);font-weight:100;text-transform:uppercase;margin:0;margin-bottom:30px;">
    <div class="container"><a class="navbar-brand" href="index.jsp"><img src="assets/img/LOGO.png"></a><button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-1"><span class="sr-only">Toggle navigation</span></button>
        <div class="collapse navbar-collapse"
             id="navcol-1">
            <ul class="nav navbar-nav ml-auto">
                <li class="nav-item" role="presentation"><a class="nav-link" href="index.jsp" style="color:#ffffff;">Strona Główna</a></li>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#" style="color:#ffffff;">Oferta zabiegowa</a></li>
                <li class="nav-item" role="presentation"><a class="nav-link" href="#" style="color:#ffffff;">Oferta sprzedażowa</a></li>
                <li class="nav-item" role="presentation"><a class="nav-link" href="index.jsp#kontakt" style="color:#ffffff;">Kontakt</a></li>
                <% if(session.getAttribute("userData") == null){ %>
                    <li class="nav-item" role="presentation"><a class="nav-link" href="P_User/logowanie.jsp" style="color:#ffffff;">Logowanie</a></li>
                <% }else{ %>
                    <li class="nav-item" role="presentation"><a class="nav-link" href="P_User/account.jsp" style="color:#ffffff;">Moje Konto</a></li>
                    <li class="nav-item" role="presentation"><a class="nav-link" href="UserLogin" style="color:#ffffff;">Wyloguj</a></li>
                <% } %>

            </ul>
        </div>
    </div>
</nav>
</body>
</html>
