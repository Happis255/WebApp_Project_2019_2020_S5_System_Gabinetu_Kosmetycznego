<%@ page import="myPage.basicObjects.Pracownik" %>
<%@ page import="myPage.data.dataBase.PracownikData" %>
<%@ page import="myPage.data.others.ErrorMessage" %>
<%@ page import="myPage.data.others.SessionData" %>
<%@ page import="myPage.exceptions.NoResultsException" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: ppisk
  Date: 18.12.2019
  Time: 17:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<% SessionData sessionData = (SessionData)session.getAttribute("userData"); %>

<section style="margin-bottom:30px;">
    <div class="jumbotron" style="background-color:rgba(0,0,0,0.11);color:#ffffff;padding-bottom:20px;padding-top:20px;max-width:800px;margin-right:auto;margin-left:auto;">
        <br>DANE TWOJEGO KONTA:
        <%
            Pracownik user = null;
            PracownikData data;
            try {
                user = new Pracownik(sessionData.getId());

                data = user.getData();
                if(data == null)
                    throw new NoResultsException();
            } catch (SQLException | NoResultsException e) {
                ErrorMessage errorMessage = new ErrorMessage(e);
                session.setAttribute("errorMessage", errorMessage);
                response.sendRedirect("errorPage.jsp");
                return;
            }

        %> <br><br> <%

        out.println("Imie:" + data.getImie() + "<br>");
        out.println("Nazwisko:" + data.getNazwisko() + "<br>");
        out.println("Ulica:" + data.getUlica() + "<br>");
        out.println("kod_pocztowy:" + data.getKod_pocztowy() + "<br>");
        out.println("miejscowosc:" + data.getMiejscowosc() + "<br>");
        out.println("data_urodzenia:" + data.getData_urodzenia() + "<br>");
        out.println("telefon:" + data.getTelefon() + "<br>");
        out.println("e_mail:" + data.getE_mail() + "<br>");
        out.println("id_klienta:" + data.getId() + "<br>");
        out.println("id_konta:" + data.getId_konta() + "<br><br>");
        out.println("pesel:" + data.getPesel() + "<br>");
        out.println("data_zatrudnienia:" + data.getData_zatrudnienia() + "<br>");
        out.println("certyfikaty:" + data.getCertyfikaty() + "<br>");
        out.println("id_ksiarzeczki:" + data.getId_ksiazeczki() + "<br>");
    %>
    </div>
</section>
</html>
