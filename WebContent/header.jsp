<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="it.unisa.etm.model.bean.*,java.util.*"%>
<%
	Amministratore admin = (Amministratore) session.getAttribute("admin");
	Utente utente = (Utente) session.getAttribute("utente");
	if(utente==null && admin == null){
		response.sendRedirect("./index.jsp");
	    return;
	}
	ArrayList<Partecipa> partecipazioni = (ArrayList<Partecipa>) session.getAttribute("listaPartecipazione");
	if(partecipazioni == null)
		partecipazioni = new ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.1/css/all.css"
	integrity="sha384-gfdkjb5BdAXd+lj+gudLWI+BXq4IuLW5IT+brZEZsLFm++aCMlF1V92rMkPaX4PP"
	crossorigin="anonymous">

<title>ETM Platform</title>
<link href="https://fonts.googleapis.com/css?family=Roboto"
	rel="stylesheet">

</head>


<body>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
		integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
		crossorigin="anonymous"></script>

	<nav class="navbar navbar-expand-lg navbar-light bg-white">
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarTogglerDemo03"
			aria-controls="navbarTogglerDemo03" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<a class="navbar-brand" href="#"><img alt="load"
			src="img/logo.png" width="60" height="60"></a> <span
			style="color: orange;">ETM Platform</span>

		<div class="collapse navbar-collapse" id="navbarTogglerDemo03">


			<ul class="navbar-nav mr-auto mt-2 mt-lg-0">
				<li class="nav-item"><a class="nav-link text-dark"
					href="homePage.jsp" id="home">Home <span class="sr-only"></span>
				</a></li>
				<%if(utente!=null){ %>
				<li class="nav-item"><a class="nav-link text-dark"
					href="ListaProposteTesiAttiveServlet" id="areaTesi">Area
						proposta tesi</a></li>
				<%if (utente.getTipo().equals("s")&&(utente.getPropostaTesi_Id()>0)) { %>
				<li class="nav-item"><a class="nav-link text-dark"
					href="VisualizzaListaConsegneServlet" id="areaCondivisa">Area
						privata condivisa</a></li>
				<%
				}
				%>

				<%
					if (utente.getTipo().equals("d")&&(partecipazioni.size()>0)) { 
 					%>
				<li class="nav-item"><a class="nav-link text-dark"
					href="VisualizzaListaPartecipazioneServlet" id="areaCondivisa">Area
						privata condivisa</a></li>
				<%} %>


				<li class="nav-item d-lg-none d-xl-none"><a
					class="nav-link text-dark"
					href="VisualizzaProfiloUtenteServlet?utente_email=<%=utente.getEmail()%>"
					id="profilo">Profilo</a></li>
				<%}else if(admin!=null){ %>

				<li><a class="nav-link text-dark" href="ListaUtentiServlet"
					id="admin">Area Admin</a></li>



				<%} %>

				<li class="nav-item d-lg-none"><a class="nav-link text-dark"
					href="LogoutServlet">Logout</a></li>


			</ul>
			<%if(admin==null){ %>
			<form class="form-inline my-2 my-lg-0"
				action="CercaListaUtentiServlet" method="post" name="cercaProfilo">
				<div class="container">
					<input class="form-control mr-sm-2 border-dark" type="text"
						name="cerca" placeholder="Cerca" aria-label="Cerca"> <select
						class="form-control mr-sm-2 border-dark" name="option">
						<option value="nome">Nome</option>
						<option value="cognome">Cognome</option>
					</select>
					<button type="submit"
						class="btn btn-inline my-2 my-sm-0 bg-warning "
						id="exampleButton1">
						<span class="fa fa-search"></span>
					</button>
				</div>
			</form>
			<%} %>
			<%if(utente!=null) {%>
			<form action="VisualizzaProfiloUtenteServlet" method="post"
				class="d-none d-lg-block d-xl-block">
				<input type="hidden" name="utente_email"
					value="<%=utente.getEmail()%>">
				<button class="btn btn-inline mr-3 bg-warning" type="submit">
					<span class="fa fa-user-circle"></span>
				</button>
			</form>
			<%} %>
			<ul class="navbar-nav d-none d-lg-block d-xl-block">

				<li class="nav-item">
					<form action="LogoutServlet" method="post">
						<button class="btn btn-inline my-2 my-sm-0 bg-warning"
							type="submit">
							<span class="fas fa-sign-out-alt form-control-feedback"></span>
						</button>
					</form>
				</li>
			</ul>
			<%if(utente!=null) {%>
			<i class="my-2 ml-3" style="color: orange;">Benvenuto, <%=utente.getNome() %></i>
			<%}else if(admin!=null){ %>
			<i class="my-2 ml-3" style="color: orange;">Benvenuto, <%=admin.getNome() %></i>
			<%} %>
		</div>
	</nav>

</body>
</html>