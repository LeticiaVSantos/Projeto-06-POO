
<%@page import="br.com.fatecpg.cars.Period"%>
<%@page import="java.util.Date"%>
<%@page import="br.com.fatecpg.cars.Price"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    String error = null;
    Long id = null;
    Period period = null;
    int hours = 0;
    double price = 0;
    try{
        id = Long.parseLong(request.getParameter("id"));
        period = Period.getPeriod(id);
        Date now = new Date();
        hours = now.getHours() - period.getRetirada().getHours();
        price = hours * Price.getCurrentPrice();
        
         if(request.getParameter("formFinishPeriod")!= null){
        
        try{
           
           Period.finishPeriod(id, price);
           response.sendRedirect(request.getContextPath()+"/operation/rent.jsp");
           
        }catch(Exception e){
            error = "Erro na leitura do registro de estadia do veículo: " + e.getMessage();
        }
    }
        
    }catch(Exception ex){
        error = ex.getMessage();
    }
   
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Devolução - ParkingWebApp</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf"%>
    <center>
        <h1>Finalizar Aluguel</h1>
        
        <%if(error!=null){%>
        <h3><%=error%></h3>
        <%}%>
        <%if(session.getAttribute("user")==null){%>
        <h2>É preciso estar autenticado para acessar este recurso</h2>
        <%}else if(period != null){%>
            <% User user = (User) session.getAttribute("user"); %>
       
            <form>
                <h3>ID: <%= id %></h3>
                <h3>Modelo: <%= period.getModel() %></h3>
                <h3>Placa: <%= period.getPlate() %></h3>
                <h3>Horas: <%= hours %></h3>
                <h3>Preço: R$ <%= price %></h3>
                <input type="hidden" value="<%= id %>" name="id"/>
                <h3><input type="submit" name="formFinishPeriod" value="Finalizar Aluguel"/>&nbsp;&nbsp;<a href="rent.jsp">Voltar</a></h3>
                
            </form>
        
        <%}%>
        
    </center>
    </body>
</html>
