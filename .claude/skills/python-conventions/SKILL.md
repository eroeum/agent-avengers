---
description: Python conventions, patterns, and best practices for Django, FastAPI, Flask, pytest, and general Python development.
user-invocable: false
---

# Python Conventions

## Code Style & Idioms
- PEP 8 compliance and idiomatic Python
- Type hints on public function signatures (`def func(x: int) -> str:`)
- Use `Optional[T]` or `T | None` for nullable values
- Type collection contents (`list[str]`, `dict[str, int]`)
- Use `TypedDict` for dictionary shapes, `Protocol` for structural typing
- Use `@overload` for functions with different return types based on input
- Context managers for resource handling (`with` statements)
- List comprehensions over manual loops where clearer
- F-strings for string formatting
- Proper use of `__init__.py`, module structure, and imports
- Virtual environment and dependency pinning in `requirements.txt` / `pyproject.toml`
- Use dataclasses or Pydantic models instead of raw dicts
- Use generators instead of lists for large datasets

## Frameworks

### Django
- Apps, models, views/viewsets, serializers, middleware, signals
- Use `select_related` / `prefetch_related` to fix N+1 queries
- Use `values()` / `values_list()` for lightweight querysets
- Check `INSTALLED_APPS`, migrations, URL routing when debugging
- CSRF token enforcement on state-changing views
- Never expose `SECRET_KEY` or run `DEBUG=True` in production
- Migrations: `python manage.py makemigrations` / `migrate`
- Use `django-debug-toolbar` to identify slow queries

### FastAPI
- Routers, dependencies, Pydantic schemas, middleware
- Use `Depends()` for dependency injection
- Pydantic models for request/response validation
- Async endpoints with `async def` for I/O-bound work
- Uvicorn output, structured logging via `structlog`

### Flask
- Blueprints, extensions, application factories
- Marshmallow or Pydantic for schema validation
- Check route decorators, app context, blueprint registration when debugging

## Testing
- Framework: pytest (preferred), unittest as fallback
- Use `pytest.fixture` for shared setup, `pytest.mark.parametrize` for data-driven tests
- Mock with `unittest.mock.patch` or `pytest-mock`
- Run: `pytest -v` or `python -m pytest`
- Use `conftest.py` for shared fixtures
- Async tests with `pytest-asyncio`

## Security
- SQL injection via string formatting in raw queries (use parameterized queries)
- `pickle` / `yaml.load` deserialization of untrusted data
- Jinja2 template injection (`|safe` filter misuse)
- `eval()`, `exec()`, `subprocess` with `shell=True`
- Missing rate limiting on authentication endpoints

## Performance
- Use `functools.lru_cache` or `@cache` for expensive pure functions
- Async I/O with `asyncio` for concurrent network/file operations
- Profile with `cProfile` or `py-spy`
- Replace loops with vectorized operations (NumPy/Pandas) where applicable

## Database (Django ORM / SQLAlchemy)
- Django: review `models.py`, check for N+1 in serializers and views
- SQLAlchemy: review model definitions, session management, relationship loading
- Migrations: `python manage.py makemigrations` / `alembic revision --autogenerate`

## Documentation
- Use Google-style or NumPy-style docstrings (match existing convention)
- Triple-quoted strings under the function/class definition
- Module-level docstring at the top of the file
- Sphinx or MkDocs format if the project uses them

## Dependencies
- Files: `requirements.txt`, `pyproject.toml`, `Pipfile`, `setup.py`, `setup.cfg`
- Audit: `pip audit`, `pip list --outdated`, `safety check`
- Watch for: pinned vs unpinned versions, `>=` vs `==` constraints

## CI/CD
- Virtual environment activation and correct Python version
- Missing dependencies (requirements.txt out of sync)
- `pytest` collection errors or import failures
- Linting failures (`flake8`, `ruff`, `black`, `mypy`)

## Debugging
- Read the full traceback bottom-up (most recent call last)
- Common: `ImportError`, `AttributeError`, `TypeError`, `KeyError`
- Check virtual environment activation and dependency versions

## Regex
- Use raw strings (`r"pattern"`)
- Named groups: `(?P<name>...)`
- `re.VERBOSE` for readable multi-line patterns
