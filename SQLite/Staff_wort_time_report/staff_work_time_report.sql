-- Staff work time report broken down by time of day

with params as(
	--Always one row, We are using dummy table
	select date('2024-11-01') start_date,  date('2025-05-30') stop_date, 1 unit_id 
)
,src as(
	SELECT
		wh.wh_id, t.task_id, wh.start_time intime,  wh.stop_time  outtime, (julianday(wh.stop_time) - julianday(wh.start_time)) * 1440 AS difference_in_minutes,
		wh.personel_role, wh.personel_id
	FROM params param
	join work_hours wh on 1=1
	join tasks t on t.task_id = wh.task_id
	join projects p on p.project_id = t.project_id
	join organizational_units ou on ou.unit_id = p.unit_id
	where wh.personel_role is not null  and ou.unit_id = param.unit_id and ( date(wh.start_time) between date(param.start_date) and date(param.stop_date))
)
,employee_task_total as(
	select count(*) employee_task_total, personel_id, personel_role from (select distinct task_id, personel_id, personel_role from src) group by personel_id, personel_role
)   
--We are using recursion to divide the period into individual minutes
,splitting AS (
    select
		s.wh_id,
		datetime(s.intime) AS start_time,
		datetime(s.intime, '+1 minute') AS end_time
    from src s 
    union all
    select s.wh_id, datetime(r.start_time, '+1 minute'), datetime(r.end_time, '+1 minute')
    from splitting r
    join src s on s.wh_id = r.wh_id
    where start_time < datetime(s.outtime, '-1 minute')
)
,callendaring as(
	  select  
	  1 one,
	  case when hc.kind_of_holiday is not null then 'Y' else 'N' end holiday,
	  case when time(s.start_time) >= '07:00:00' and time(s.start_time) < '15:00:00' then 'M' else 'E' end daytime_period,
	  sr.personel_role,
	  sr.personel_id, 
	  s.* 
  from splitting s
  join src sr on sr.wh_id = s.wh_id
  left join holiday_calendar hc on date(s.start_time) = date(hc.date)
)
,grouping as(
  select  c.personel_id, c.personel_role, c.holiday || daytime_period gr, sum(one) total_minutes 
  from callendaring c
  group by c.personel_id, c.personel_role, c.holiday, daytime_period
)
,pivoting as (
  select  
    g.personel_id,
	g.personel_role,
	sum( case when g.gr = 'NM' then total_minutes else 0 end) nm,
	sum( case when g.gr = 'NE' then total_minutes else 0 end) ne,
	sum( case when g.gr = 'YM' then total_minutes else 0 end) ym,
	sum( case when g.gr = 'YE' then total_minutes else 0 end) ye
  from grouping g
  group by g.personel_id, g.personel_role
  order by g.personel_id, g.personel_role
)
,formatting1 as(
  select 
	  p.personel_role,
	  p.personel_id,
	  nm,
	  ne,
	  ifnull(p.ym,0)+ifnull(p.ye,0) t,
	  ifnull(p.nm,0)+ifnull(p.ne,0) + ifnull(p.ym,0)+ifnull(p.ye,0) s
  from pivoting p
)
,formatting2 as(
  select   
	l.name as "Employee",
	d.dictionary_entry_name as "Personel role", 
	lo.employee_task_total as "Total number of completed tasks",
    COALESCE( (((nm/ 60) )) ||':'|| PRINTF('%02d',(mod(nm, 60) )) ||'' ,'-') as "Total worktime 7-15 [hours:minutes]",
    COALESCE( (((ne/ 60) )) ||':'|| PRINTF('%02d',(mod(ne, 60) )) ||'' ,'-') as "Total worktime 15-7 [hours:minutes]",
    COALESCE( (((t/ 60) )) ||':'|| PRINTF('%02d',(mod(t, 60) )) || '','-') "Total worktime Holiday [hours:minutes]", 
    COALESCE( (((s/ 60) )) ||':'|| PRINTF('%02d',(mod(s, 60) )) || '','-') "Tatal worktime [hours:minutes]", s "Total worktime [minutes]"
  from formatting1 f
  join personel l on f.personel_id = l.personel_id
  left join employee_task_total lo on lo.personel_id = f.personel_id and lo.personel_role = f.personel_role
  left join dictionary_entries d on d.dictionary_code = 'PERS_ROLE' and d.dictionary_entry_code = f.personel_role
  order by l.name
)
SELECT * FROM formatting2