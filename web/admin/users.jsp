
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    String error = null;
    if(request.getParameter("formDeleteUser")!=null){
        try{
            long id = Long.parseLong(request.getParameter("id"));
            User.removeUser(id);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
        }
    }
    if(request.getParameter("formNewUser") != null){
        String name = request.getParameter("name");
        String role = request.getParameter("role");
        String login = request.getParameter("login");
        long passwordHash = request.getParameter("pass").hashCode();
        User.addUser(name, role, login, passwordHash);
        try{
            User.addUser(name, role, login, passwordHash);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
            error = e.getMessage();
        }
    }
%>

<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/css.css" rel="stylesheet">
        <link rel="icon" href="../Imagens/favicon.ico">
        
        <title>ToRent Cars - Usuários</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf" %>
    <center><h1>Usuários</h1></center>
    
    <hr>
    
    <%if(session.getAttribute("user")==null){%>
    
    <center><h2>É preciso estar autenticado para acessar este recurso</h2>
        <%}else{%>
            <% User user = (User) session.getAttribute("user"); %>
            <%if(!user.getRole().equals("ADMIN")){%>
            <h2>Você não tem permissão para acessar este recurso</h2>
    </center>
            
        <%}else{%>
        <%if(error!=null){%>
        <h3><%=error%></h3>
        <%}%>
        <center>
            
        <fieldset>
            
            <h5><legend>Novo Usuário</legend></h5>
            <br>
            
            <form>
               <div class="form-group col-md-2">
                <label for="inputName">Nome: </label>
                 <input type="text" name="name" class="form-control" id="inputName" placeholder="Nome">
                </div>
                   
                <div class="form-group col-md-2">
                <label for="inputRole">Papel: </label>
                <select name="role" id="inputRole" class="form-control">
                
                    <option value="ADMIN">ADMIN</option>
                    <option value="OPERADOR">OPERADOR</option>
                    
                </select>
                </div>
                   
               <div class="form-group col-md-2">
                   
                <label for="inputLogin">Login</label>  
                <input type="text" name="login" class="form-control" id="inputLogin" placeholder="Login"/>
                
               </div>
                   
                <div class="form-group col-md-2">
                    
                <label for="inputPassword4">Senha: </label>
                <input type="password" name="pass" class="form-control" id="inputPassword4" placeholder="Senha"/>
                
                </div>
                    
               </div>
                
               <input class="btn btn-success btn-lg" type="submit" name="formNewUser" value="Adicionar"/>
                
            </form>
            
        </fieldset>
        </center>
        <br>
        
        <table class="table table-bordered">
            <tr class="table-primary">
                <th scope="col">ID</th>
                <th scope="col">Papel</th>
                <th scope="col">Nome</th>
                <th scope="col">Login</th>
                <th scope="col">Comando</th>
            </tr>
            <%for(User u: User.getUsers()){%>
            <tr>
                <td><%=u.getId()%></td>
                <td><%=u.getRole()%></td>
                <td><%=u.getName()%></td>
                <td><%=u.getLogin()%></td> 
                <td>
                    <form>
                        <input type="hidden" name="id" value="<%=u.getId()%>"/>
                        <input class="btn btn-danger" type="submit" name="formDeleteUser" value="Remover"/>
                    </form>
                </td>
            </tr>
            <%}%>            
        </table>
        <%}%> <%}%> 
    
    </body>
</html>
