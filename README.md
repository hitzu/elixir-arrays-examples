# OnboardingElixir

Proyecto de onboarding en Elixir con ejercicios de funciones, pipes, procesos servidor y transformación de listas con Enum.

## Requisitos previos

- Elixir ~> 1.19
- Mix (incluido con Elixir)

## Instalación

```bash
mix deps.get
mix compile
```

## Ejecutar procesos (Playground)

Los scripts en la carpeta `playground/` se ejecutan con `mix run`:

```bash
mix run playground/<archivo>.exs
```

### Scripts disponibles

| Script                         | Descripción                                                                   |
| ------------------------------ | ----------------------------------------------------------------------------- |
| `01_func_geometry.exs`         | Calcula el área de un rectángulo usando `Geometry`                            |
| `01_pipes_calculator.exs`      | Ejemplo de pipes: suma con `Math` + cálculo de impuestos con `TaxCalculator`  |
| `01_server_process.exs`        | `AdderServer`: proceso que suma dos números                                   |
| `02_server_array.exs`          | `ArrayActions`: operaciones sobre listas (length, first, last, reverse, etc.) |
| `02_server_array_old.exs`      | Versión anterior del servidor de arrays                                       |
| `02_server_tax_calculator.exs` | `TaxCalculatorServer`: cálculo de impuestos vía proceso servidor              |
| `03_list_ops_enum.exs`        | **ListOps**: estilo happy path con Enum.map, filter, reduce, group_by, chunk_every |

### Ejemplos

```bash
mix run playground/01_func_geometry.exs
mix run playground/01_pipes_calculator.exs
mix run playground/01_server_process.exs
mix run playground/02_server_array.exs
mix run playground/02_server_tax_calculator.exs
mix run playground/03_list_ops_enum.exs
```

## ListOps - Transformación de listas

El módulo `OnboardingElixir.Playground.ListOps` implementa funciones de transformación en estilo Elixir happy path usando `Enum`:

| Función | Enum usado | Descripción |
|---------|------------|-------------|
| `map/2` | Enum.map | Transforma cada elemento con la función dada |
| `filter/2` | Enum.filter | Filtra elementos que cumplen el predicado |
| `sum/1` | Enum.reduce | Suma los números (reduce idiomático) |
| `group_by/2` | Enum.group_by | Agrupa elementos por la clave de key_fun |
| `chunk_every/2` | Enum.chunk_every | Divide la lista en chunks de tamaño n |
| `reverse/1` | Enum.reverse | Invierte el orden de la lista |
| `concat/2` | ++ | Concatena dos listas |

## Tests

Ejecutar todos los tests:

```bash
mix test
```

Ejecutar un archivo de tests específico:

```bash
mix test test/playground/adder_server_test.exs
mix test test/playground/array_server_test.exs
mix test test/playground/server_array_test.exs
mix test test/playground/geometry_server_test.exs
mix test test/playground/list_ops_test.exs
mix test test/playground/tax_calculator_server_test.exs
mix test test/playground/tax_calculator_test.exs
```

Ejecutar un test específico por número de línea:

```bash
mix test test/playground/array_server_test.exs:14
```
