



from django.shortcuts import render, redirect
from django.contrib import messages
from django.http import HttpResponse
from django.db import connection  # Uses settings.py config

# 🎬 View: List Actors
def actor_list(request):
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT first_name, full_name, dob 
            FROM actor 
            ORDER BY actor_id DESC 
            LIMIT 5
        """)
        rows = cursor.fetchall()

    actor = [{'Firstname': r[0], 'Fullname': r[1], 'Birthdate': r[2]} for r in rows]
    return render(request, 'act_list.html', {'actor': actor})

# 🔍 View: Search Actor by First Name
def search_actor(request):
    query = request.GET.get('name', '').strip()
    actor = None
    searched = False

    if query:
        like_query = f"%{query}%"
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT actor.first_name, actor.full_name 
                FROM actor 
                WHERE actor.first_name ILIKE %s
            """, [like_query])
            row = cursor.fetchone()
        searched = True

        if row:
            actor = {'Firstname': row[0], 'Fullname': row[1]}

    return render(request, 'search_act.html', {'actor': actor, 'searched': searched})

# ➕ View: Add New Actor
def add_actors(request):
    if request.method == 'POST':
        fname = request.POST.get('fname', '').strip()
        lname = request.POST.get('lname', '').strip()

        with connection.cursor() as cursor:
            cursor.execute("""
                INSERT INTO actor (first_name, family_name) 
                VALUES (%s, %s)
            """, [fname, lname])
            connection.commit()

        messages.success(request, f"Actor or actress {fname} {lname} added.")
        return redirect('actor_list')

    return render(request, 'add_actors.html')

