%%[
/* ====== DATOS BASE ====== */
SET @nombreCompleto = AttributeValue("Consulta__c:Nombre__c")
SET @codigoCarrera = AttributeValue("Consulta__c:Codigo_Carrera__c")

/* ====== SALUDO PERSONALIZADO ====== */
SET @nombreTrim = Trim(@nombreCompleto)
SET @spacePos = IndexOf(@nombreTrim, " ")

IF @spacePos > 0 THEN
  SET @primerNombreRaw = Substring(@nombreTrim, 1, Subtract(@spacePos, 1))
ELSE
  SET @primerNombreRaw = @nombreTrim
ENDIF

SET @primerNombre = ProperCase(Lowercase(@primerNombreRaw))
SET @saludo = IIF(Empty(@primerNombre), "¡Hola!", Concat("¡Hola ", @primerNombre, "!"))

SET @asunto = IIF(
  Empty(@primerNombre),
  "Tu próximo paso profesional empieza hoy",
  Concat(@primerNombre, ", tu próximo paso profesional empieza hoy")
)

/* ====== DATOS DINÁMICOS POR CARRERA ====== */
SET @deCarreras = "DE_DinamicoCarreras_POS"

IF Empty(@codigoCarrera) THEN
  SET @nombreCarrera      = "la carrera"
ELSE
  SET @rows = LookupRows(@deCarreras, "Codigo_Carrera", @codigoCarrera)

  IF RowCount(@rows) > 0 THEN
    SET @row = Row(@rows, 1)
    SET @nombreCarrera      = Field(@row, "Nombre_Carrera")
  ELSE
    SET @nombreCarrera      = "la carrera"
  ENDIF
ENDIF

/* Fallbacks por seguridad */
IF Empty(@nombreCarrera) THEN SET @nombreCarrera = "la carrera" ENDIF

]%%


%%=v(@asunto)=%%
