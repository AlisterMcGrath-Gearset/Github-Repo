global class FlowScheduler implements Schedulable, Queueable {
    private String flowName;

    // Constructor for Queueable
    public FlowScheduler(String flowName) {
        this.flowName = flowName;
    }

    // Default constructor for Schedulable
    public FlowScheduler() {}

    global void execute(SchedulableContext context) {
        // Enqueue jobs to trigger the flows every hour
        System.enqueueJob(new FlowScheduler('NULL_POINTER'));
        System.enqueueJob(new FlowScheduler('QUERY_EXCEPTION'));
        System.enqueueJob(new FlowScheduler('LIST_EXCEPTION'));
    }

    public void execute(QueueableContext context) {
        try {
            // Execute the specified flow
            Flow.Interview flow = Flow.Interview.createInterview(flowName, new Map<String, Object>());
            flow.start();
        } catch (Exception e) {
            System.debug('Error executing flow: ' + flowName + ' - ' + e.getMessage());
        }
    }

    // Method to schedule the job every hour
    public static void scheduleJob() {
        String cronExp = '0 0 * * * ?';
        System.schedule('FlowScheduler_Hourly', cronExp, new FlowScheduler());
    }
}