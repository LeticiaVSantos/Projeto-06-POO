
<%@page import="java.util.Date"%>
<%@page import="br.com.fatecpg.cars.Price"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    String error = null;
    if(request.getParameter("formDeletePrice")!=null){
        try{
            long id = Long.parseLong(request.getParameter("id"));
            Price.removePrice(id);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
        }
    }
    if(request.getParameter("formNewPrice")!= null){
        
        try{
            double price = Double.parseDouble(request.getParameter("price"));
            Price.addPrice(new Date(), price);
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
        <title>Preços - ToRent Cars</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf"%>
    <center>
        <h1>Preços</h1>
        <%if(session.getAttribute("user")==null){%>
        <h2>É precisoestar autenticado para acessar este recurso</h2>
        <%}else{%>
            <% User user = (User) session.getAttribute("user"); %>
            
        <%if(error!=null){%>
        <h3><%=error%></h3>
        <%}%>
        <fieldset>
            <legend>Adicionar Novo Preço</legend>
            <form>
                <div class="form-group col-md-2">
                 <input type="text" name="price" class="form-control" id="inputPrice" placeholder="Preço"> &nbsp;&nbsp;
                 <br><input class="btn btn-success" type="submit" name="formNewPrice" value="Adicionar"/>
                </div>
            </form>
        </fieldset>
      
        <table class="table table-bordered">
            <tr class="table-primary">
                <th scope="col">ID</th>
                <th scope="col">Data/hora</th>
                <th scope="col">Preço</th>
                <th scope="col">comando</th>
                
            </tr>
            <%for(Price p: Price.getPrices()){%>
            <tr>
                <td><%=p.getId()%></td>
                <td><%=p.getTimestamp()%></td>
                <td><%=p.getPrice()%></td>
                
                <td>
                    <form>
                        <input type="hidden" name="id" value="<%=p.getId()%>"/>
                        <input class="btn btn-danger" type="submit" name="formDeletePrice" value="Remover"/>
                    </form>
                </td>
            </tr>
            <%}%>            
        </table>
        <%}%>
        
    </center>
    </body>
</html>
