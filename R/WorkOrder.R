
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
  #获取参数
  text_WorkOrder=tsui::var_text('text_WorkOrder')


  #查询按钮

  shiny::observeEvent(input$btn_WorkOrder_view,{

    FWorkOrder=text_WorkOrder()


    if(FWorkOrder==''){

      tsui::pop_notice("Please Enter Work Order")


    }else{

      erp_token = rdbepkg::dbConfig(FAppId = app_id, FType = "ERP", FRunEnv = run_env)


      data = mdlVMWorkOrderPkg::WorkOrder_select(erp_token = erp_token,FWorkOrderID = FWorkOrder)
      tsui::run_dataTable2(id ='WorkOrder_resultView' ,data =data )

      tsui::run_download_xlsx(id = 'dl_WorkOrder',data = data,filename = 'WorkOrder.xlsx')


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
