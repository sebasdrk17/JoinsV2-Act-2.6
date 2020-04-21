-- 1. Obtener el número de cuenta, nombre completo y total de cursos (cuyo dato se llamará
-- total_cursos_inscritos) a los que está inscrito cada uno de los alumnos. TIP group by

select
    numero_cuenta,
    concat(
        nombre," ",primer_apellido," ",segundo_apellido
    )as nombre_completo,
    count(id_alumno)as total_cursos_inscritos
from
    alumnos
    left join alumnos_cursos 
        on numero_cuenta=id_alumno
group by numero_cuenta

--left join por que puede haber datos en null, al pasarse los datos de alumnos_cursos a alumnos, algunos datos no estan llenados
--en caso de usarse inner join esos datos se van a omitir al no tener nigun valor

-- 2. Obtener el número de cuenta, nombre completo y total de cursos (cuyo dato se llamará
-- total_cursos_inscritos) a los que está inscrito cada uno de los alumnos cuando estos estén
-- inscritos a 2 cursos o más, ordenando los resultados por el mayor número de cursos y por
-- nombre completo ascendentemente. TIP. Having

select
    numero_cuenta,
    concat(
        nombre," ",primer_apellido," ",segundo_apellido
    )as nombre_completo,
    count(id_alumno)as total_cursos_inscritos
from
    alumnos
    left join alumnos_cursos 
        on numero_cuenta=id_alumno
group by 
    nombre_completo
Having
    total_cursos_inscritos>1
order by
    total_cursos_inscritos desc, nombre_completo asc

--having, aqui se puede utilzar la variable del count que utilizamos, ya que tenemos ese numero comparamos que sea mayor a 1
--order by, ordenamos de manera descendente los numeros para que el mayor este al principio, y los nombres de manera ascendente para hacerlo alfabeticamente

-- 3. Obtener la cantidad de cursos que se impartieron o impartirán por año, nombrando año a
-- la columna correspondiente al año y al total de cursos como total_cursos

select
    YEAR(fecha_inicio) as año,
    count(id_curso) as total_cursos
from 
    cursos_profesores
group by
    año

--obtenemos el año con la funcion year y luego la cantidad de cursos totales que hay, por ultimo las agrupamos por fecha y listo

-- 4. Obtener el número de trabajador, nombre completo del profesor, nombre del curso y
-- promedio de todos los alumnos de todos los cursos que se impartieron o impartirán en el
-- año en curso, si no cuenta con alumnos inscritos para mostrar el promedio entonces
-- mostrar un -1; ordenar los resultados por promedio de mayor a menor y por nombre del
-- profesor alfabéticamente

--funciona 3 partes de la tabla num | nombre | curso
select
    numero_trabajador,
    concat(
        profesores.nombre," ",primer_apellido," ",segundo_apellido
    )as nombre_completo,
    cursos.nombre
from
    profesores
    left join cursos_profesores
        on numero_trabajador=id_profesor
    left join cursos
        on id_curso=cursos.id
    -- left join alumnos_cursos
    --     on id_curso_profesor=cursos.id
where
    YEAR(fecha_inicio)='2020'
group by cursos.nombre
