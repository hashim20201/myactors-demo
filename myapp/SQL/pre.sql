
# from django.shortcuts import render,redirect
# from django.contrib import messages
# from django.http import HttpResponse
# #from .db_utils import get_sql_server_connection
# #from .db_utils import get_postgres_connection

# def actor_list(request):
#     #conn = get_sql_server_connection()
#     conn = get_postgres_connection()
#     cursor = conn.cursor()
#     cursor.execute("SELECT top 5 firstname, fullname, Dob FROM Actor order by actorid desc")
#     rows = cursor.fetchall()
#     conn.close()

#     # Convert rows to list of dicts for easier template rendering
#     actor = [{'Firstname': r[0], 'Fullname': r[1], 'Birthdate': r[2]} for r in rows]

#     return render(request, 'act_list.html', {'actor': actor})


# def search_actor(request):
#     query = request.GET.get('name')
#     actor = None
#     searched = False
#     print(query)

#     if query:
#         conn = get_postgres_connection()
#         cursor = conn.cursor()

#         # Add wildcards for partial match
#         like_query = f"%{query}%"
#         cursor.execute("SELECT firstname,fullname FROM actor WHERE firstname LIKE ?", (like_query,))
#         row = cursor.fetchone()
#         conn.close()
#         searched = True

#         if row:
#             actor = {'Firstname': row[0], 'Fullname': row[1]}

#     return render(request, 'search_act.html', {'actor': actor, 'searched': searched})
#     #return render(request, 'search_act.html')

# def add_actors(request):
#     if request.method == 'POST':
#         fname = request.POST.get('fname','').strip()
#         lname = request.POST.get('lname','').strip()
#         conn = get_sql_server_connection()
#         cursor = conn.cursor()
#         cursor.execute("INSERT INTO actor (firstname,familyname) VALUES (?,?)",[fname,lname])
#         conn.commit()
#         cursor.close()
#         conn.close

#         messages.success(request, f"Actor or actress {fname} {lname} added ")
#         #return HttpResponse(f"<h2>Record for {fname} {lname} is added succefully</h2>")
#         return redirect('actor_list')
#     return render(request,'add_actors.html')