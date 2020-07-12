from sqlalchemy import create_engine

engine = create_engine('sqlite:///:memory:')
connection = engine.connect()
