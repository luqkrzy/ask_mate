from flask import render_template, redirect, request, Blueprint, url_for
import askmate.data_manager as data_manager

main = Blueprint('main', __name__)


@main.route("/")
def route_home():
    order_direction = request.args.get('order_direction', 'asc')
    switch_order_direction = data_manager.switch_asc_desc(order_direction)

    if request.args.get('search_phrase') is not None:
        return redirect(url_for('questions.route_search'))

    elif request.args.get('tag_id') is not None:
        return redirect(url_for('questions.route_tag'))

    questions = data_manager.sort_and_paginate_questions(request_args=dict(request.args), direction=switch_order_direction)

    return render_template('index.html', questions=questions, asc_desc=switch_order_direction)

