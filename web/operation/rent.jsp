<%@page import="br.com.fatecpg.cars.Period"%>
<%@page import="java.util.Date"%>
<%@page import="br.com.fatecpg.cars.Price"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    String error = null;
    if(request.getParameter("formDeletePeriod")!=null){
        try{
            long id = Long.parseLong(request.getParameter("id"));
            Price.removePrice(id);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
        }
    }
    if(request.getParameter("formNewPeriod")!= null){
        
        try{
           String model = request.getParameter("model");
           String plate = request.getParameter("plate");
           
           String retirada = request.getParameter("retirada");
           String hr_retirada = request.getParameter("hr_retirada");
           
           String dev = request.getParameter("dev");
           String hr_dev = request.getParameter("hr_dev");
          
           
           Period.addPeriod(model, plate, retirada, hr_retirada, dev, hr_dev);
           response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="../Imagens/favicon.ico">
        <title>Carros Alugados - ToRent Cars</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf"%>
    <center>
        <h1>Registrar Carros Alugados</h1>
        <%if(session.getAttribute("user")==null){%>
        <h2>É preciso estar autenticado para acessar este recurso</h2>
        <%}else{%>
            <% User user = (User) session.getAttribute("user"); %>
            
        <%if(error!=null){%>
        <h3><%=error%></h3>
        <%}%>
        <br>
        <fieldset>
            
            <form>
                Modelo: <input type="text" name="model"/>
                Placa: <input type="text" name="plate"/>
                Data da retirada: <input type="date" name="retirada"/>
                Hora da retirada: <input type="time" name="hr_retirada"/>
                Data da devolução: <input type="date" name="dev"/>
                Hora da devolução: <input type="time" name="hr_dev"/>&nbsp;&nbsp;
                <input type="submit" name="formNewPeriod" value="Registrar Aluguel"/>
                
            </form>
            <br><br>
        </fieldset>
        
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Modelo</th>
                <th>Placa</th>
                <th>Data da retirada</th>
                <th>Hora da retirada</th>
                <th>Data da devolução</th>
                <th>Hora da devolução</th>
                <th>Comando</th>
                
            </tr>
            <%for(Period p: Period.getPeriods()){%>
            <tr>
                <td><%=p.getId()%></td>
                <td><%=p.getModel()%></td>
                <td><%=p.getPlate()%></td>
                <td><%=p.getRetirada()%></td>
                <td><%=p.getHr_retirada()%></td>
                <td><%=p.getDev()%></td>
                <td><%=p.getHr_dev()%></td>
                
                <td>
                    <a href="finish-period.jsp?id<%=p.getId()%>">Finalizar</a>
                    
                </td>
            </tr>
            <%}%>            
        </table>
        <%}%>
    </center>
    
    <hr>
    
    <footer>
        <center>
          <p>© 2018 Copyright:</p>
             
            <a href='https://github.com/LeticiaVSantos/Projeto-06---POO.git'</a>Projeto 06
            </center>
    </footer>
    
    <br>
    
    </body>
</html>
