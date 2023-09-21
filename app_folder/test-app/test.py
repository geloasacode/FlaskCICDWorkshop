import os
import pytest
import sys
sys.path.append("..")
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_main_page(client):
    response = client.get('/')
    assert response.status_code == 200

def test_color_page(client):
    response = client.get('/color')
    assert response.status_code == 200
    assert response.data.decode('utf-8') in ["red", "green", "blue", "blue2", "darkblue", "pink"]

def test_version_page(client):
    response = client.get('/version')
    assert response.status_code == 200
    assert "Hello, Application Version" in response.data.decode('utf-8')

def test_info_page(client):
    response = client.get('/info')
    assert response.status_code == 200
    assert "Hello, Application Version" in response.data.decode('utf-8')

# Add more test cases as needed


