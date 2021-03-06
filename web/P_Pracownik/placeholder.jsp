<%@ page import="java.sql.SQLException" %>
<%@ page import="myPage.basicObjects.Wydarzenie" %>
<%@ page import="myPage.data.dataBase.WydarzenieData" %>
<%@ page import="myPage.data.others.SessionData" %>
<%@ page import="myPage.data.others.TypKonta" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<%
    session = request.getSession();
    SessionData sessionData = (SessionData) session.getAttribute("userData");
%>

<section id="baza_uslug" class="bg-light-gray" style="margin:0;background-color:rgba(0,0,0,0.11);color:#ffffff;padding-bottom:20px;padding-top:20px;max-width:1140px;margin-right:auto;margin-left:auto;border-radius:20px;margin-bottom:30px;">
    <form action="${pageContext.request.contextPath}/SingInEvents" method="post">
        <h2 class="text-center" style="height:79px;">Wydarzenia</h2>
        <h5 class="text-center" style="height:21px;margin-right:50px;margin-left:50px;">Poniżesz zamieszczona jest lista wydarzeń znajdująca się w systemie</h5>
        <h6 class="text-center" id="informacja" style="height:44px;margin-right:50px;margin-left:50px;font-weight: 100;">Zaznacz dane wydarzenia i potwierdź operację, by wziąć w nim udział.</h6>


        <table id="wydarzenia" class="table" cellspacing="0" width="100%" style="text-align: center;margin-bottom: 0;border: 3px solid #FFFFFF;width: 98%;max-width: 98%;margin-left: 12px;background-color: transparent;border-collapse: collapse;">
            <thead>
            <tr>
                <th></th>
                <th>TYP</th>
                <th>NAZWA</th>
                <th>OPIS</th>
                <th>ULICA</th>
                <th>KOD POCZTOWY</th>
                <th>MIEJSCOWOSC</th>
                <th>DATA OD</th>
                <th>DATA DO</th>
                <th>KOSZT</th>
            </tr>
            </thead>
            <tbody>

            <%
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Wydarzenie event = new Wydarzenie();
                WydarzenieData temp;

                try {
                    event.getEverything();
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                while (!event.isEmpty()){
                    temp = event.pop();

                    out.println("<tr>" +
                            "<td> <input type=\"Checkbox\" Name=\"do_zapisania\" Value =\"" + temp.getId() + "\"></td>" +
                            "<td>" + temp.getOpisTypuWydarzenia() + "</td>" +
                            "<td>" + temp.getNazwa() + "</td>" +
                            "<td>" + temp.getOpis() + "</td>" +
                            "<td>" + temp.getUlica() + "</td>" +
                            "<td>" + temp.getKod_pocztowy() + "</td>" +
                            "<td>" + temp.getMiejscowosc() + "</td>" +
                            "<td>" + dateFormat.format(temp.getData_od()) + "</td>" +
                            "<td>" + dateFormat.format(temp.getData_do()) + "</td>" +
                            "<td>" + temp.getKosz() + " PLN</td></tr>");
                }
            %>

            </tbody>
        </table>
        <a href="#"><button class="btn btn-primary float-none align-self-center" type="submit" style="width:265px;position:static;text-align:center!important;margin-left:437px;margin-top:20px;">Zapisz się na wydarzenie</button></a>
    </form>
</section>
</html>