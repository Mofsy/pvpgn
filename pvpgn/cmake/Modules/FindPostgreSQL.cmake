# - Find libpq
# Find the native PostgreSQL includes and library
#
#  PGSQL_INCLUDE_DIR - where to find libpq-fe.h, etc.
#  PGSQL_LIBRARIES   - List of libraries when using PGSQL.
#  PGSQL_FOUND       - True if PGSQL found.

IF (PGSQL_INCLUDE_DIR)
  # Already in cache, be silent
  SET(PostgreSQL_FIND_QUIETLY TRUE)
ENDIF (PGSQL_INCLUDE_DIR)

FIND_PATH(PGSQL_INCLUDE_DIR libpq-fe.h
  /usr/local/pgsql/include
  /usr/local/include/pgsql
  /usr/local/include
  /usr/include/pgsql
  /usr/include
  /usr/pgsql/include
)

SET(PGSQL_NAMES pq)
SET(PGSQL_SEARCH_LIB_PATHS 
  /usr/local/pgsql/lib /usr/local/lib /usr/lib
)
FIND_LIBRARY(PGSQL_LIBRARY
  NAMES ${PGSQL_NAMES}
  PATHS ${PGSQL_SEARCH_LIB_PATHS}
)

IF (PGSQL_INCLUDE_DIR AND PGSQL_LIBRARY)
  SET(PGSQL_FOUND TRUE)
  SET( PGSQL_LIBRARIES ${PGSQL_LIBRARY} )
ELSE (PGSQL_INCLUDE_DIR AND PGSQL_LIBRARY)
  SET(PGSQL_FOUND FALSE)
  SET( PGSQL_LIBRARIES )
ENDIF (PGSQL_INCLUDE_DIR AND PGSQL_LIBRARY)

IF (PGSQL_FOUND)
  IF (NOT PostgreSQL_FIND_QUIETLY)
    MESSAGE(STATUS "Found PostgreSQL: ${PGSQL_LIBRARY}")
  ENDIF (NOT PostgreSQL_FIND_QUIETLY)
ELSE (PGSQL_FOUND)
  IF (PostgreSQL_FIND_REQUIRED)
    MESSAGE(STATUS "Looked for PostgreSQL libraries named ${PGSQL_NAMES}.")
    MESSAGE(FATAL_ERROR "Could NOT find PostgreSQL library")
  ENDIF (PostgreSQL_FIND_REQUIRED)
ENDIF (PGSQL_FOUND)

MARK_AS_ADVANCED(
  PGSQL_LIBRARY
  PGSQL_INCLUDE_DIR
)
