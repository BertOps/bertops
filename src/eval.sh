export data_type="camelcase"
export model="bert-base-uncased"
export output_dir="bertops"
export saved_checkpoint="1285000"

python -m torch.distributed.launch \
    --nproc_per_node 1 \
    --master_port 29501 \
    run_mlm.py \
        --model_name_or_path $output_dir/checkpoint-$saved_checkpoint \
        --validation_file ../data/pretrain/test.txt \
        --per_device_eval_batch_size 64 \
        --do_eval \
        --line_by_line \
        --output_dir $output_dir \
        --max_seq_length 512 \
        --line_by_line \
        --cache_dir $output_dir/cache \
        --eval_accumulation_steps 256 \
        --report_to none \
        --dataloader_num_workers 4 \
        --ddp_find_unused_parameters False