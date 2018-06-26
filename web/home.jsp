
<%@page import="br.com.fatecpg.cars.Price"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="Imagens/favicon.ico">
        <title>Home - ToRent Cars</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
    <center><h1>Página Inicial</h1> <br>
        
        <% if(Price.getCurrentPrice() == null){ %>
    <h3>[Preço não definido pela administração do Estacionamento]</h3>
    <%} else {%>
       <h3>Preço especial para o aluguel de carros R$ <%= Price.getCurrentPrice() %></h3>
    <%}%>
    
    </center>
        
    </body>
</html>
