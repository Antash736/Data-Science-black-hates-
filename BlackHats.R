library(patchwork)
library(grid)
library(gridExtra)
library(shiny)
library(shinythemes)
library(DT)
library(dplyr)
library(readr)
library(arules)
library(arulesViz)
library(ggplot2)
library(DataEditR)
library(tidyverse)
library(tidyquant)

ui <- fluidPage(
  theme = shinytheme("cyborg"),
  navbarPage(
    "Black Hats Project",
    tabPanel("Visualization",
             sidebarLayout(
               sidebarPanel(
                 fileInput("file", "Choose CSV File", accept = ".csv"),
                 selectInput("visual", label = "Choose:", c("Cash & Credit", "Age with total", "Frequency with total", "Each City With total", "All Visualizations"))
               ),
               mainPanel(
                 plotOutput(outputId = "visual1")
               )
             )
    ),
    tabPanel("K-means",
             sidebarLayout(
               sidebarPanel(
                 tags$h3("Enter your value(2:4):"),
                 numericInput("cluster", "", 3, min = 2, max = 4, step = 1)
               ),
               mainPanel(DTOutput(outputId = "cluster1"))
             )
    ),
    tabPanel("Apriori",
             sidebarLayout(
               sidebarPanel(
                 sliderInput("support", "Support:", min = 0.001, max = 1, value = 0.01, step = 0.001),
                 sliderInput("confidence", "Confidence:", min = 0.001, max = 1, value = 0.01, step = 0.001),
               ),
               mainPanel(
                 tableOutput("apriori")
               )
             )
    ),
    tabPanel("About", 
             fluidRow(
               column(12, 
                      h3("عن مشروع Black Hats"),
                      p("المشروع ده معمول عشان يساعدك في تحليل بيانات العملاء باستخدام أدوات تفاعلية، وبكده تقدر تاخد قرارات قائمة على بيانات دقيقة."),
                      p("البرنامج بيتيح ليك رفع ملف بيانات CSV فيه بيانات العملاء وتطبيق عدة مهام تحليلية على البيانات، زي:"),
                      tags$ul(
                        tags$li("1. رفع وتنظيف البيانات: تقدر ترفع ملف CSV فيه بيانات العملاء. والبرنامج بيشيل القيم الشاذة (outliers) والأخطاء تلقائي."),
                        tags$li("2. عرض البيانات بشكل مرئي: في البرنامج فيه عدة رسومات زي Pie Chart علشان تعرف طرق الدفع (كاش أو كريدت)، و Bar Plot علشان تحلل أعمار العملاء، وHistogram علشان تحلل الصرف."),
                        tags$li("3. تحليل التجمعات (Clustering): باستخدام خوارزمية K-means، البرنامج بيقسم العملاء إلى مجموعات حسب أعمارهم وصرفهم. وكده تقدر تعرف العملاء اللي بيصرفوا أكتر أو الفئات العمرية."),
                        tags$li("4. اكتشاف العلاقات بين المنتجات (Apriori): البرنامج بيستخدم خوارزمية Apriori علشان يكتشف العلاقات بين المنتجات اللي الناس بتشتريها مع بعض، عشان تقدر تعمل عروض أو باقات منتجات.")
                      ),
                      p("المشروع هيساعدك في:"),
                      tags$ul(
                        tags$li("فهم أنماط الصرف وتوزيع عملائك بطريقة سهلة."),
                        tags$li("اكتشاف فرص جديدة لتسويق المنتجات."),
                        tags$li("تحليل توزيع العملاء حسب الموقع الجغرافي والبيانات الديموغرافية."),
                        tags$li("اتخاذ قرارات معتمدة على بيانات دقيقة بدلاً من التخمين.")
                      ),
                      p("التقنيات المستخدمة في المشروع:"),
                      tags$ul(
                        tags$li("R Shiny: لإنشاء التطبيق التفاعلي."),
                        tags$li("ggplot2 و patchwork: لإنشاء الرسومات البيانية."),
                        tags$li("arules و arulesViz: لتحليل العلاقات بين المنتجات باستخدام خوارزمية Apriori."),
                        tags$li("dplyr و tidyverse: لتنظيم وتحليل البيانات بسرعة وكفاءة.")
                      ),
                      p("تم تطوير بواسطة: BLACK HATS TEAM ")
               )
             )
    )
  )
)

server <- function(input, output) {
  
  blackhats_data <- reactiveVal(NULL)
  blackhats_backup <- reactiveVal(NULL)
  result2 <- reactive({
    req(blackhats_data())  
    blackhats <- blackhats_data() 
    
    if(!"sum_total" %in% colnames(blackhats)) {
      colnames(blackhats)[colnames(blackhats) == "total"] <- "sum_total"
    }
    Formaldehyde<-function(x){
      sum(x)
    }
    result2 <- aggregate(sum_total ~ paymentType + rnd + age, data = blackhats, FUN = Formaldehyde)
    result2
  })
  result <- reactive({
    req(blackhats_data())  
    blackhats <- blackhats_data() 
    
    if(!"sum_total" %in% colnames(blackhats)) {
      colnames(blackhats)[colnames(blackhats) == "total"] <- "sum_total"
    }
    
    result <- aggregate(sum_total ~ rnd + age, data = blackhats, FUN = sum)
    result
  })
  result3 <- reactive({
    req(blackhats_data())  
    blackhats <- blackhats_data() 
    
    if(!"sum_total" %in% colnames(blackhats)) {
      colnames(blackhats)[colnames(blackhats) == "total"] <- "sum_total"
    }
    Formaldehyde<-function(x){
      sum(x)
    }
    result3 <- aggregate(sum_total ~ city + rnd + age, data = blackhats, FUN = Formaldehyde)
    result3
  })
  result4 <- reactive({
    req(blackhats_data())  
    blackhats <- blackhats_data() 
    
    if(!"sum_total" %in% colnames(blackhats)) {
      colnames(blackhats)[colnames(blackhats) == "total"] <- "sum_total"
    }
    Formaldehyde<-function(x){
      sum(x)
    }
    result4 <- aggregate(sum_total ~ customer + rnd + age, data = blackhats, FUN = Formaldehyde<-function(x){
      sum(x)
    })
    result4
  })
  
  blackhats_new <- reactive({
    req(blackhats_data())
    blackhats_data() %>%
      select(age, sum_total)  # اختيار الأعمدة المطلوبة
  })
  observe({
    req(input$file)  
    dff <- read.csv(input$file$datapath)  
    df <- unique(dff)
    blackhats <- na.omit(df)
    
    outlier_count <- boxplot(blackhats$count)$out
    outlier_age <- boxplot(blackhats$age)$out
    outlier_total <- boxplot(blackhats$total)$out
    
    blackhats <- blackhats[!blackhats$count %in% outlier_count,]
    blackhats <- blackhats[!blackhats$age %in% outlier_age,]
    blackhats <- blackhats[!blackhats$total %in% outlier_total,]
    
    colnames(blackhats)[colnames(blackhats) == "total"] <- "sum_total"
    blackhats_data(blackhats) 
    blackhats_backup(blackhats) 
  })
  
  output$visual1 <- renderPlot({
    req(result2())  
    
    # تعريف الألوان للمدن
    city_colors <- c(
      "Alexandria" = "red",
      "Aswan" = "orange",
      "Cairo" = "yellow",
      "Dakahlia" = "green",
      "Fayoum" = "blue",
      "Gharbia" = "purple",
      "Giza" = "cyan",
      "Hurghada" = "pink",
      "Port Said" = "brown",
      "Sohag" = "darkblue"
    )
    
    # رسم الـ Pie Chart باستخدام ggplot
    paymentType <- table(result2()$paymentType)
    percentage <- round(100 * prop.table(paymentType), 1)
    
    # إنشاء Pie Chart باستخدام ggplot
    pie_data <- data.frame(
      paymentType = names(paymentType),
      percentage = percentage
    )
    
    pie_chart <- ggplot(pie_data, aes(x = "", y = percentage, fill = paymentType)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar(theta = "y") +
      labs(title = "Pie Chart of Payment Type") +
      theme_void() +
      scale_fill_manual(values = c("steelblue1", "tomato")) +
      geom_text(aes(label = paste(percentage, "%")), position = position_stack(vjust = 0.5), color = "black")
    
    # رسم Plot1
    plot1 <- ggplot(result(), aes(x = age, y = sum_total, fill = age)) + 
      geom_bar(stat = "identity") + 
      labs(y = "Sum Total", title = "The total money paid by age of customers")
    
    # رسم Plot2
    plot2 <- ggplot(result(), aes(x = sum_total)) +
      geom_histogram(bins = 30, fill = "skyblue", color = "black") +
      theme_light() +
      labs(title = "Distribution of Total Spending", x = "Total Spending", y = "Frequency")
    
    # رسم Plot3 (Total Money per City)
    plot3 <- ggplot(result3(), aes(x = city, y = sum_total, fill = city)) + 
      geom_bar(stat = "identity") + 
      scale_fill_manual(values = city_colors, na.value = "grey") +
      theme_minimal() +
      labs(
        title = "Total Money per City",
        x = "City",
        y = "Total"
      ) +
      scale_y_continuous(labels = scales::comma) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))  # لجعل أسماء المدن عمودية
    
    # ترتيب الرسومات باستخدام patchwork
    if(input$visual == "Cash & Credit(PieChart)") {
      print(pie_chart)
    } else if(input$visual == "Plot1") {
      print(plot1)
    } else if(input$visual == "Plot2") {
      print(plot2)
    } else if(input$visual == "Plot3") {
      print(plot3)
    } else if(input$visual == "All Visualizations") {
      # عرض كل الرسومات الأربعة مع تضمين الـ Pie Chart في المكان الفاضي
      final_plot <- (plot1 | plot2) / (plot3 | pie_chart) # دمج Pie Chart مع باقي الرسومات
      print(final_plot)
    }
  })
  
  # حساب الـ k-means بناءً على الأعمدة age و sum_total من blackhats_data
  
  
  kmeans_result <- reactive({
    req(blackhats_new())
    kmeans(blackhats_new(), centers = input$cluster)  # حساب الـ k-means
  })
  
  output$cluster1 <- renderDT({
    req(blackhats_data())
    # إنشاء DataFrame جديد يحتوي على الأعمدة المطلوبة + إضافة عمود clusters
    kmeans_output <- data.frame(
      customer = blackhats_data()$customer,       # إضافة عمود العملاء
      age = blackhats_data()$age,                 # إضافة عمود العمر
      sum_total = blackhats_data()$sum_total,     # إضافة عمود المجموع
      clusters = kmeans_result()$cluster   # إضافة عمود الـ clusters
    )
    
    # عرض الـ DataFrame الناتج في واجهة المستخدم
    datatable(kmeans_output)
  })
  apriori_data <- reactive({
    req(blackhats_data())  # التأكد من وجود البيانات
    
    blackhats <- blackhats_data()
    
    # التحقق من وجود العمود "items" في البيانات
    if (!"items" %in% colnames(blackhats)) {
      print("Error: 'items' column is missing.")
      return(NULL)
    }
    
    # تحويل البيانات إلى قائمة من المعاملات
    transactions <- strsplit(blackhats$items, ",") 
    
    # كتابة البيانات إلى ملف CSV لقراءتها بواسطة read.transactions
    write.table(sapply(transactions, function(x) paste(x, collapse = ",")), 
                file = "transactions.csv", 
                row.names = FALSE, col.names = FALSE, quote = FALSE)   
    
    # قراءة المعاملات باستخدام حزمة arules
    transactions_data <- read.transactions("transactions.csv", format = "basket", sep = ",")
    summary(transactions_data)  # عرض ملخص البيانات
    
    # تطبيق خوارزمية Apriori
    rules <- apriori(transactions_data, parameter = list(supp = input$support, conf = input$confidence))
    
    # تصفية القواعد بناءً على lift
    filtered_rules <- subset(rules, lift > 1.5)
    
    # كتابة النتائج إلى ملف CSV
    write.csv(as(rules, "data.frame"), "rules_output.csv")
    
    # إرجاع القواعد المصفاة لعرضها
    list(rules = rules, filtered_rules = filtered_rules)
  })
  
  output$apriori <- renderTable({
    apriori_result <- apriori_data()
    
    if (is.null(apriori_result)) return(NULL)
    
    # عرض القواعد المصفاة
    as(apriori_result$filtered_rules, "data.frame")
  })
  
  output$rule_summary <- renderPrint({
    apriori_result <- apriori_data()
    
    if (is.null(apriori_result)) return(NULL)
    
    # عرض ملخص القواعد المستخرجة
    inspect(apriori_result$filtered_rules)
  })
}
shinyApp(ui = ui, server=server)