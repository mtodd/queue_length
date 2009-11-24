class QueueLength < Scout::Plugin
  def build_report
    length = %x{total=0; for i in `rabbitmqctl list_queues -p demandbase-api | grep tokens | grep usage | cut -f 2`; do total=$(($i+$total)); done; echo $total}.chomp.to_i
    report(:queued => length)
    if length > 0
      alert("The queue currently has #{length} messages in it.")
    end
  end
end
