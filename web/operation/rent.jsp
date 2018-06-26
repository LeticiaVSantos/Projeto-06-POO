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
                <div class="form-group col-md-2">
                <label for="inputModel">Modelo: </label>
                 <input type="text" name="model" class="form-control" id="inputModel" placeholder="Modelo">
                </div>
                <div class="form-group col-md-2">
                <label for="inputPlate">Placa: </label>
                 <input type="text" name="plate" class="form-control" id="inputPlate" placeholder="Placa">
                </div>
                <div class="form-group col-md-2">
                <label for="inputRetirada">Data da retirada: </label>
                 <input type="date" name="retirada" class="form-control" id="inputRetirada" placeholder="Retirada">
                </div>
                <div class="form-group col-md-2">
                <label for="inputHr_retirada">Hora da retirada: </label>
                 <input type="time" name="hr_retirada" class="form-control" id="inputHr_retirada" placeholder="Hora da retirada">
                </div>
                <div class="form-group col-md-2">
                <label for="inputDev">Data da devolução: </label>
                 <input type="date" name="dev" class="form-control" id="inputDev" placeholder="Devolução">
                </div>
                <div class="form-group col-md-2">
                <label for="inputDev">Hora da devolução: </label>
                 <input type="time" name="hr_dev" class="form-control" id="inputDev" placeholder="Hora da devolução">
                </div>
                
                <input class="btn btn-success" type="submit" name="formNewPeriod" value="Registrar Aluguel"/>
                
            </form>
            <br><br>
        </fieldset>
        
        <table class="table table-bordered">
            <tr class="table-primary">
                <th scope="col">ID</th>
                <th scope="col">Modelo</th>
                <th scope="col">Placa</th>
                <th scope="col">Data da retirada</th>
                <th scope="col">Hora da retirada</th>
                <th scope="col">Data da devolução</th>
                <th scope="col">Hora da devolução</th>
                <th scope="col">Comando</th>
                
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
