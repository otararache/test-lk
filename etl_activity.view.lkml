view: etl_load_activity {
  derived_table: {
    sql: SELECT
        CONVERT(VARCHAR(19), CAST(ODSLoadDate AS DATE), 120)  as odsload_date,
        RIGHT('0' + CONVERT(VARCHAR(2), DATEPART(HOUR, ODSLoadDate)), 2) + ':00' as odsload_hour
      from employee
      where ODSLoadDate > getdate()-10
       ;;
  }

  measure: record_count {
    type: count
    drill_fields: [detail*]
  }

  dimension: load_date {
    type: string
    sql: ${TABLE}.load_date ;;
  }

  dimension: load_hour {
    type: string
    sql: ${TABLE}.odsload_hour ;;
  }

  set: detail {
    fields: [load_date, load_hour]
  }
}
