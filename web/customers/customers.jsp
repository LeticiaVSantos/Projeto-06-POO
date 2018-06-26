
<%@page import="br.com.fatecpg.cars.Customers"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    String error = null;
    if(request.getParameter("formDeleteCustomers")!=null){
        try{
            long id = Long.parseLong(request.getParameter("id"));
            Customers.removeCustomers(id);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
        }
    }
   
    if(request.getParameter("formNewCustomers") != null){
        String customer_name = request.getParameter("customer_name");
        String rg = request.getParameter("rg");
        String cpf = request.getParameter("cpf");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");
        Customers.addCustomers(customer_name, rg, cpf, address, telephone, email);
        try{
            Customers.addCustomers(customer_name, rg, cpf, address, telephone, email);
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
        <title>Clientes - ToRent Cars</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
    <center><h1>Clientes</h1></center>
    
    <hr>
    
    <%if(session.getAttribute("user")==null){%>
    
    <center><h2>É preciso estar autenticado para acessar este recurso</h2></center>
        <%}else{%>
            <% User user = (User) session.getAttribute("user"); %>
            <%if(!user.getRole().equals("ADMIN") & !user.getRole().equals("OPERADOR")){%>
    <center><h2>Você não tem permissão para acessar este recurso</h2></center>
    
          
        <%}else{%>
        <%if(error!=null){%>
        <h3><%=error%></h3>
        <%}%>
        <center>
        <fieldset>
            <h5><legend>Cadastro de Clientes</legend></h5>
            <br>
            <form>
                Nome: <input type="text" name="customer_name"/>
                RG: <input type="text" name="rg"/>
                CPF: <input type="text" name="cpf"/>
                Endereço: <input type="text" name="address"/>
                Telefone: <input type="text" name="telephone"/>
                E-mail: <input type="text" name="email"/>
                
                
                <input class="btn btn-success" type="submit" name="formNewCustomers" value="Registrar"/>
                
            </form>
        </fieldset>
        </center>
        <br>
        
        <table class="table table-bordered" >
            <tr class="table-primary">
                <th scope="col">ID</th>
                <th scope="col">Nome</th>
                <th scope="col">RG</th>
                <th scope="col">CPF</th>
                <th scope="col">Endereço</th>
                <th scope="col">Tefefone</th>
                <th scope="col">E-mail</th>
                <th scope="col">Comando</th>
            </tr>
            <%for(Customers c: Customers.getCustomers()){%>
            <tr>
                <td><%=c.getId()%></td>
                <td><%=c.getCustomer_Name()%></td>
                <td><%=c.getRg()%></td>
                <td><%=c.getCpf()%></td> 
                <td><%=c.getAddress()%></td>
                <td><%=c.getTelephone()%></td>
                <td><%=c.getEmail()%></td>
                <td>
                    <form>
                        <input type="hidden" name="id" value="<%=c.getId()%>"/>
                        <input class="btn btn-danger" type="submit" name="formDeleteCustomers" value="Remover"/>
                    </form>
                </td>
            </tr>
            <%}%>            
        </table>
        <%}%> <%}%> 
    
    </body>
</html>
