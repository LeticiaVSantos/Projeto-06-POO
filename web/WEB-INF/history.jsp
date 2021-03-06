<%-- 
    Document   : history
    Created on : 25/06/2018, 18:56:43
    Author     : Fabricinho
--%>

<%@page import="java.time.Period"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String error = null;
    String plate = null;
    String date = null;
    if(request.getParameter("formFilter ")!=null){
        
        date = request.getParameter("date");
        if(date.isEmpty()) date = null;
        plate = request.getParameter("plate");
        if(plate.isEmpty()) plate = null;
            
        }
    %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <title>ToRent Cars - Clientes</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
    <center><h1>Histórico</h1></center>

     <%if(session.getAttribute("user")==null){%>
    
    <center><h2>É preciso estar autenticado para acessar este recurso</h2>
        <%}else{%>
            <% User user = (User) session.getAttribute("user"); %>
            <%if(error != null ){%>
            <h2><%= error %></h2>
            <%}%>
    </center>
           
        
        <center>
        <fieldset>
            <h5><legend>Filtro</legend></h5>
            <br>
            <form>
                Data:<input type="date" name="date"/>
                Placa:<input type="text" name="plate"/> 
                <input class="btn btn-success" type="submit" name="formFilter" value="Filtrar"/>
                
        <table class="table table-bordered" >
            <tr class="table-primary">
                <th scope="col">ID</th>
                <th scope="col">Modelo</th>
                <th scope="col">Placa</th>
                <th scope="col">Entrada</th>
                <th scope="col">Saida</th>
                <th scope="col">Preço</th>
            </tr>
            <%for(Period p: Period.getHistory(date, plate)){%>
            <tr>
                <td><%=p.getId()%></td>
                <td><%=p.getModel()%></td>
                <td><%=p.getPlate()%></td>
                <td><%=p.getBegin()%></td> 
                <td><%=p.getEnd()%></td> 
                <td><%=p.getPrice()%></td> 
                <td>
                    <form>
                        <input type="hidden" name="id" value="<%=p.getId()%>"/>
                        <input class="btn btn-danger" type="submit" name="formDeleteUser" value="Remover"/>
                    </form>
                </td>
            </tr>
            <%}%>            
        </table>
        <%}%> <%}%> 
    
                
    </body>
</html>
