
#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param app_id
#' @param run_env
#' @param session 会话
#'
#' @return 返回值
#' @export
#'
#' @examples
#' WorkOrderSelectServer()
WorkOrderSelectServer <- function(input,output,session,app_id, run_env = "PRD") {
  # 获取所有字段名
  WorkOrder_all_columns <- c(
    'Work OrderID',
    'Work OrderId2',
    'Production Date',
    'Sales OrderID',
    'Delivery Location',
    'Sales OrderID2',
    'PN',
    'Product Name',
    'Serial Number',
    'Sales OrderQty',
    'Delivery Date',
    'Total DeliveryQty'
  )

  #设置默认值
  WorkOrder_default_columns <- c(
    'Work OrderID',
    'PN',
    'Product Name',
    'Serial Number',
    'Production Date',
    'Sales OrderID',
    'Delivery Location'
  )
  WorkOrder_reset_columns <- c(
    'Work OrderID',
    'Serial Number'
  )

  # 全选按钮
  observeEvent(input$btn_WorkOrder_select_all, {
    updatePickerInput(
      session = session,
      inputId = "WorkOrder_column_selector",
      selected = WorkOrder_all_columns
    )
  })

  # 取消全选按钮
  observeEvent(input$btn_WorkOrder_deselect_all, {
    updatePickerInput(
      session = session,
      inputId = "WorkOrder_column_selector",
      selected = WorkOrder_reset_columns
    )
  })
  # 默认值按钮
  observeEvent(input$btn_WorkOrder_defaultValue, {
    updatePickerInput(
      session = session,
      inputId = "WorkOrder_column_selector",
      selected = WorkOrder_default_columns
    )
  })
  #获取参数
  text_WorkOrder=tsui::var_text('text_WorkOrder')
  #查询按钮
  # 显示选择信息
  output$WorkOrder_selection_info <- renderPrint({
    selected <- input$WorkOrder_column_selector
    cat("Column Count: ", length(selected), "\n")
    cat("Column List: ", paste(selected, collapse = ", "), "\n")
    FOrderNumber=text_WorkOrder()
    cat("Work Order Number:",FOrderNumber)
  })



  #查询按钮

  shiny::observeEvent(input$btn_WorkOrder_view,{

    FWorkOrder=text_WorkOrder()


    if(FWorkOrder==''){

      tsui::pop_notice("Please Enter Work Order")


    }else{

      erp_token = rdbepkg::dbConfig(FAppId = app_id, FType = "ERP", FRunEnv = run_env)


      data = mdlVMWorkOrderPkg::WorkOrder_select(erp_token = erp_token,FWorkOrderID = FWorkOrder)

      data_selected = data[ ,input$WorkOrder_column_selector,drop=FALSE]
      # 增加对英文支持
      tsui::run_dataTable2(id ='WorkOrder_resultView' ,data =data_selected,lang='en' )

      tsui::run_download_xlsx(id = 'dl_WorkOrder',data = data_selected,filename = 'WorkOrder.xlsx')


    }


  })



}


#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param app_id
#' @param run_env
#' @param session 会话
#'
#' @return 返回值
#' @export
#'
#' @examples
#' WorkOrderServer()
WorkOrderServer <- function(input,output,session, app_id, run_env = "PRD") {
  WorkOrderSelectServer(input = input,output = output,session = session,app_id=app_id, run_env = run_env)


}
