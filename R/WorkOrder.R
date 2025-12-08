
#' 处理逻辑
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' WorkOrderSelectServer()
WorkOrderSelectServer <- function(input,output,session,dms_token,erp_token) {
  #获取参数
  text_WorkOrder=tsui::var_text('text_WorkOrder')


  #查询按钮

  shiny::observeEvent(input$btn_WorkOrder_view,{

    FWorkOrder=text_WorkOrder()


    if(FWorkOrder==''){

      tsui::pop_notice("Please Enter Work Order")


    }else{
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
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples
#' WorkOrderServer()
WorkOrderServer <- function(input,output,session,dms_token,erp_token) {
  WorkOrderSelectServer(input = input,output = output,session = session,dms_token = dms_token,erp_token=erp_token)


}
